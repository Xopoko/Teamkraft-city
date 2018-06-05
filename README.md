# Teamkraft-city
Задание:
Тут есть пример самого простого использования rx data source - https://github.com/ReactiveX/RxSwift/blob/master/RxExample/RxExample/Examples/SimpleTableViewExample/SimpleTableViewExampleViewController.swift

1. Нужно используя URLSession.shared.rx.response получить список городов через https://teamkraft.net/api/v2/city (там простой json, ошибки сети можно не обрабатывать) и вывести их названия в таблице, используя rx data source.
2. Если список пустой, нарисовать на весь экран вьюшку с кнопкой update
3. На кнопку update послать запрос на /city заново и обновить таблицу, убрав полноэкранную вьюшку если пришел непустой ответ. 

Все это нужно сделать в функциональном стиле, чтобы не хранить список городов в отдельной переменной. И чтобы запрос не дублировался (не было отдельного запроса для проверки списка на пустоту).
