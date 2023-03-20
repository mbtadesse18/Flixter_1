//
//  RelatedViewController.swift
//  Flixter
//
//  Created by Mariamawit Tadesse on 3/19/23.
//

import UIKit

class RelatedViewController: UIViewController, UITableViewDataSource {

    var movies: [Movie] = []
    
    var movieID: Int!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Error", message: "No recommended movies found.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                    style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        
        // Create a URL for the request
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID ?? 0)/similar?api_key=f4e3c86bb0a5e868953fee29d32a094b")!

        // Use the URL to instantiate a request
        let request = URLRequest(url: url)

        // Create a URLSession using a shared instance and call its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        // When finished, it calls it's completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            
            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
            // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
            do {
                            // Create a JSON Decoder
                            let decoder = JSONDecoder()
                            
                            // Use the JSON decoder to try and map the data to our custom model.
                            // TrackResponse.self is a reference to the type itself, tells the decoder what to map to.
                            let response = try decoder.decode(TracksResponse.self, from: data)

                            // Access the array of movies from the `results` property
                            let movies = response.results
                            
                            // Execute UI updates on the main thread when calling from a background callback
                            DispatchQueue.main.async {

                                // Set the view controller's movies property as this is the one the table view references
                                self?.movies = movies

                                // Make the table view reload now that we have new data
                                self?.tableView.reloadData()
                                
                                if (movies.isEmpty) {
                                    self?.present(alert, animated: true, completion: nil)
                                }
                            }
                            
                            print("✅ \(movies)")
                            
                        } catch {
                            print("❌ Error parsing JSON: \(error.localizedDescription)")
                        }
                    }

                    // Initiate the network request
                    task.resume()
                    print("👋 Below the closure")
                    print(movies)

                    tableView.dataSource = self
                    
                }

                override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)

                    // TODO: Deselect any selected table view rows

                    // Get the index path for the current selected table view row (if exists)
                    if let indexPath = tableView.indexPathForSelectedRow {

                        // Deslect the row at the corresponding index path
                        tableView.deselectRow(at: indexPath, animated: true)
                    }
                }

                override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

                    // Get the cell that triggered the segue
                    if let cell = sender as? UITableViewCell,
                       // Get the index path of the cell from the table view
                       let indexPath = tableView.indexPath(for: cell),
                       // Get the detail view controller
                       let detailViewController = segue.destination as? DetailViewController {

                        // Use the index path to get the associated track
                        let movie = movies[indexPath.row]

                        // Set the track on the detail view controller
                        detailViewController.track = movie
                    }
                }

                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return movies.count
                }

                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

                    // Get a cell with identifier, "MovieCell"
                    // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! MovieCell

                    // Get the track that corresponds to the table view row
                    let movie = movies[indexPath.row]

                    // Configure the cell with it's associated track
                    cell.configure(with: movie)

                    // return the cell for display in the table view
                    return cell
                }
            }
