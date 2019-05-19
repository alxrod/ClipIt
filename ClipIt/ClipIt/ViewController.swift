//
//  ViewController.swift
//  ClipIt
//
//  Created by Alex Rodriguez on 5/17/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import UIKit
import SwiftLinkPreview

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ClipIt"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(testAddUrl))
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Article", for: indexPath) as? ArticleCell else {
            fatalError("Unable to dequeue PersonCell")
            
        }
        
        let article = articles[indexPath.item]
        cell.sender.text = article.sender
        cell.articleName.text = article.title
//      Add image in here -----
        
//        Add constraints for the image here
        cell.renderImage.layer.borderWidth = 1
        
        
        pullPreview(url: article.url, cell: cell, index: indexPath)
    
        
        cell.layer.borderWidth = 1
        
        return cell
        
        
    }
    
    func pullPreview(url: URL, cell: ArticleCell, index: IndexPath) {
        let slp = SwiftLinkPreview()
        
//      Attempting to convert to string, knwoing that it might not go the immediately unwrapping it.
        let stringUrl = url.absoluteString
        print("\n\n New request attempt: with url \(stringUrl)")
        slp.preview(
            stringUrl,
            onSuccess: { result in
                print("\(result)")
                guard let imgUrlString = result.image else {
                    print ("image niled")
                    return
                }
                guard let imageUrl = URL(string: imgUrlString) else {return}
                cell.renderImage.load(url: imageUrl)
            },
            onError: { error in
                print("\(error)")
                print ("Preview pull failed!")
                return
            }
        )
    }
    
    
    
    @objc func testAddUrl() {
        let ac = UIAlertController(title: "Test Add Website", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        ac.addTextField()
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel",style: .cancel))
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
    
            guard let potentialURL = ac?.textFields?[0].text else { return }
            guard let acURL = URL(string: potentialURL) else {return}
            guard let sender = ac?.textFields?[1].text else { return }
            
            guard let title = ac?.textFields?[2].text else { return }
            
//            Implement in converting to actual url
            let article = Article(sender: sender, url: acURL, title: title)
            
            
            self?.articles.append(article)
            self?.collectionView.reloadData()
            self?.dismiss(animated: true)
            
        
//            self?.collectionView.reloadData()
        })
        
        present(ac, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width/3-7, height: 190)
    }
    
}


