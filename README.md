# EinfachTableview iOS
Damit wird Tableview einfach sein ... 

EinfachTableview will load data from the API, decode the JSON response, save the data locally (to use it in the offline mode).

# Installation
Add this line to your Podfile:

`pod 'EinfachTableview'`

# How to use it ?

1. Init an EinfachTableview variable:

`let einfachTableview = EinfachTableview<Codable, Object>()`
- `Codable`  is the Model that will be used to decode the JSON object from the remote API.
- `Object` is the Model that will be saved in a Realm database.

2. Set the tableview delegates to EinfachTableview:

`myTableview.delegate = einfachTableview
myTableview.dataSource = einfachTableview`

3. Set the EinfachTableview delegate to your ViewController:

`einfachTableview.einfachTVDelegate = self`

4. Make your ViewController conform to `EinfachTableviewDelegate` by implementation:
- ` func doneCallingWs() {
myTableview.reloadData()
}`

This will inform your ViewController that EinfachTableview called the remote API and you should then reload your TableView

- `cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, model: Codable) -> UITableViewCell`

In this method, populate the data in your TableViewCell.

- `manuallyDecode(object: Codable) -> [Codable]`

In case EinfachTableview does not succeed to get the list of objects from your Model, it will call this method to allow you to manually return an Array of objects.

5. If you want to save the objects locally in order to use it in the offline mode, set the local storage mode to `.realm`:

`einfachTableview.localStorageMode = .realm`

6. Call this method and pass the remote API Url in the parameter:

`einfachTableview.loadData(url: "RemoteAPIUrl")`

# Params
In case you made a change in your Model, you could use Realm migrations by setting the new schema:
`einfachTableview.realmDbVersion = newVersion`

# 🇬🇧 Questions or Suggestions ?
Please do not hesitate to email me at **marwen.doukh@protonmail.com**

# 🇩🇪 Haben Sie Fragen ?
Schicken Sie mir eine E-mail an **marwen.doukh@protonmail.com**

