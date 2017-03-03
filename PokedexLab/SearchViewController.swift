//
//  SearchViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var pokemonArray: [Pokemon] = []
    var filteredArray: [Pokemon] = []
    
    @IBOutlet weak var categoryView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryView.delegate = self;
        categoryView.dataSource = self;
        pokemonArray = PokemonGenerator.getPokemonArray()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Utility function to iterate through pokemon array for a single category
    func filteredPokemon(ofType type: Int) -> [Pokemon] {
        var filtered: [Pokemon] = []
        for pokemon in pokemonArray {
            if (pokemon.types.contains(PokemonGenerator.categoryDict[type]!)) {
                filtered.append(pokemon)
            }
        }
        return filtered
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokemonGenerator.categoryDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filteredArray = filteredPokemon(ofType : indexPath.row);
        performSegue(withIdentifier: "PokedexToCategorySegue", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let current : CategoryCell = categoryView.dequeueReusableCell(withReuseIdentifier: "categoryCellID", for: indexPath) as! CategoryCell;
        current.categoryImage.image = UIImage(named: PokemonGenerator.categoryDict[indexPath.row]!);
        return current;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CategoryViewController {
            dest.pokemonArray = filteredArray
        }
    }


}
