import UIKit
import RxCocoa
import RxSwift

class MassiveViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var updateBt = makeUpdateBt()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCities()
    }
}

//MARK: Private block
extension MassiveViewController {
    private func fetchCities() {
        tableView.dataSource = nil
        URLSession.shared.rx.response(request: makeReq())
            .map { return try JSONDecoder()
                .decode(ApiResponse.self, from: $0.data)
                .result
                .flatMap { $0.cityList }
            }
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] cities in
                self?.updateBt.isHidden = !cities.isEmpty
            })
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element.title)"
        }
    }
    
    private func makeUpdateBt() -> UIButton {
        let updateBt = UIButton(type: .system)
        view.addSubview(updateBt)
        updateBt.translatesAutoresizingMaskIntoConstraints = false
        updateBt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateBt.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        updateBt.setTitle("Update", for: .normal)
        updateBt.isHidden = true
        updateBt.rx.tap.bind { [weak self] in
            self?.fetchCities()
        }
        return updateBt
    }
    
    private func makeReq() -> URLRequest {
        let url = URL(string: "https://teamkraft.net/api/v2/city")!
        let req = URLRequest(url: url)
        return req
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
    }
}
