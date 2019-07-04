//
//  ViewController.swift
//  ImagepickerTask
//
//  Created by vijay on 03/02/19.
//  Copyright © 2019 vijay. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK:- IBOutlets
    var images = [PHAsset]()
    @IBOutlet var photosCollectionView : UICollectionView!
    
    //MARK:- Constraints and Variables
    var imgpicker = UIImagePickerController()
    
    //MARK:- View LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        getImages()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Custom Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let BVC = self.storyboard?.instantiateViewController(withIdentifier: "BViewController") as! BViewController
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        self.navigationController?.pushViewController(BVC, animated: true)
        BVC.img = cell.imageholder.image

        
    }
    func getImages() {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects({ (object, count, stop) in
            // self.cameraAssets.add(object)
            self.images.append(object)
        })
        //In order to get latest image first, we just reverse the array
        self.images.reverse()
        // To show photos, I have taken a UICollectionView
        self.photosCollectionView.reloadData()
    }

    func openGallery(){
        imgpicker.delegate = self
        imgpicker.sourceType = .photoLibrary
        imgpicker.allowsEditing = true
        self.present(imgpicker, animated: true, completion: nil)
    }
    
    func openCamera(){
        imgpicker.delegate = self
        imgpicker.sourceType = .camera
        self.present(imgpicker, animated: true, completion: nil)
    }
    
    func alerviewaction(){
        let alerview = UIAlertController(title: "Options", message: "Select Any One Option to take Image", preferredStyle: .alert)
        alerview.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(ACTION) in
            self.openCamera()
            }))
        alerview.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {(ACTION) in
            self.openGallery()
            }))
        alerview.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alerview, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let asset = images[indexPath.row]
        let manager = PHImageManager.default()
        if cell.tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(cell.tag))
        }
        cell.tag = Int(manager.requestImage(for: asset,
                                            targetSize: PHImageManagerMaximumSize,
                                            contentMode: .aspectFill,
                                            options: nil) { (result, _) in
                                                cell.imageholder?.image = result
        })
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    //MARK:- Button's Action
    @IBAction func openImagePicker(_ sender: UIButton) {
            alerviewaction()
    }
    @IBAction func camera()
    {
        openCamera()
    }
    
    
    //MARK:- UIImagePicker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var img : UIImage!
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        img = image
        dismiss(animated: true, completion: nil)
        let BVC = self.storyboard?.instantiateViewController(withIdentifier: "BViewController") as! BViewController
        self.navigationController?.pushViewController(BVC, animated: true)
        BVC.img = img

    }
}

