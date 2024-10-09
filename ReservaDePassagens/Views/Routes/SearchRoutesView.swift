import UIKit

class SearchRoutesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var datePicker: UIDatePicker!
    var fromTextField: UITextField!
    var toTextField: UITextField!
    var viewModel: RoutesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RoutesViewModel()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // Configuração de campo "De"
        fromTextField = UITextField()
        fromTextField.placeholder = "Departure Location"
        fromTextField.borderStyle = .none
        fromTextField.layer.cornerRadius = 8
        fromTextField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        fromTextField.setLeftIcon(UIImage(named: "departureIcon")) // ícone de partida
        view.addSubview(fromTextField)
        
        // Configuração de campo "Para"
        toTextField = UITextField()
        toTextField.placeholder = "Destination"
        toTextField.borderStyle = .none
        toTextField.layer.cornerRadius = 8
        toTextField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        toTextField.setLeftIcon(UIImage(named: "destinationIcon")) // ícone de destino
        view.addSubview(toTextField)
        
        // Configuração do DatePicker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor(white: 0.95, alpha: 1)
        datePicker.layer.cornerRadius = 8
        view.addSubview(datePicker)
        
        // Configuração da barra de pesquisa
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search for routes..."
        searchBar.backgroundImage = UIImage() // Remover borda
        searchBar.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(searchBar)
        
        // Configuração da tabela de resultados
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RouteCell")
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        fromTextField.translatesAutoresizingMaskIntoConstraints = false
        toTextField.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            fromTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fromTextField.heightAnchor.constraint(equalToConstant: 50),
            
            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 20),
            toTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toTextField.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchRoutes(from: fromTextField.text ?? "", to: toTextField.text ?? "", date: datePicker.date, query: searchText)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath)
        let route = viewModel.routes[indexPath.row]
        cell.textLabel?.text = route.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.imageView?.image = UIImage(named: "routeIcon") // Ícone de rota
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let route = viewModel.routes[indexPath.row]
        let detailsVC = RouteDetailsViewController(route: route)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// Extensão para adicionar ícones à esquerda dos UITextFields
extension UITextField {
    func setLeftIcon(_ icon: UIImage?) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        iconView.image = icon
        iconView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}

