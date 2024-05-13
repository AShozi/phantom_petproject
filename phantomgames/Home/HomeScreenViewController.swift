//
//  HomeScreenViewController.swift
//  phantomgames
//
//  Created by Aphiwe Shozi on 2024/04/20.
//

import UIKit

class HomeScreenViewController: UIViewController{
    
    var data = [ToDo]()
    
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //method calling
        fetchingAPIImages(URL: "https://www.freetogame.com/api/games"){ result in
            self.data = result
            DispatchQueue.main.async {
                self.HomeCollectionView.reloadData()
            }
        }
    }
    
    func fetchingAPIImages(URL Url:String, completion: @escaping ([ToDo]) -> Void){
            let url = URL(string: Url)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url!) {data, response, error in
                do {
                    let fetchingData =
                    try JSONDecoder().decode([ToDo].self, from: data!)
                    completion(fetchingData)
                } catch {
                    print("Parsing error")
                }
                
            }
            dataTask.resume()
        }
        
    }
    
    extension HomeScreenViewController: UICollectionViewDataSource{
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CustomCollectionViewCell
            
            let apiData:ToDo
            apiData = data[indexPath.item]
            if let thumbnailURL = URL(string: apiData.thumbnail) {
                       cell.apiImage.downloaded(from: thumbnailURL)
                   }
            cell.Gtitle.text = apiData.title
            return cell
        }
    }

extension UIImageView {
    func downloaded(from url: URL) {
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
               let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                
            }
            
        } .resume()
        
    }
    func downloaded(from link: String){
        guard let url = URL (string: link) else {return}
        downloaded(from: url)
    }
}
