//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var pokemonTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTable.delegate = self;
        pokemonTable.dataSource = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return pokemonArray!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath;
        performSegue(withIdentifier: "CategoryToInfoSegue", sender: nil);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PokemonCellView = tableView.dequeueReusableCell(withIdentifier: "pokemonCellId", for: indexPath) as! PokemonCellView;
        let pokemon : Pokemon = pokemonArray![indexPath.row];
        if let image = cachedImages[indexPath.row] {
            cell.pokemonImage.image = image // may need to change this!
        } else {
            let url = URL(string: pokemon.imageUrl)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.pokemonImage.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        cell.pokemonName.text = pokemon.name;
        cell.pokemonNumber.text = String(pokemon.number);
        cell.pokemonStats.text = "\(pokemon.attack!)/\(pokemon.defense!)/\(pokemon.health!)";
        return cell;
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PokemonInfoViewController {
            let s : Pokemon = pokemonArray![selectedIndexPath!.row];
            dest.pokemon = s;
        }
    }

}
