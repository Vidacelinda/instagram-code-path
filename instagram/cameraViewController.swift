//
//  cameraViewController.swift
//  instagram
//
//  Created by Carlo Leiva on 9/30/22.
//

//NOTE: have user interaction enabled so gesters on image works
import UIKit
import AlamofireImage
import Parse

class cameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //UIImagePickerControllerDelegate camera events lie call me back with a fucntion that gives bakc the image
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Post")//table name (for some reason its called className) Parse will make a table on the fly if there is no table named Pet.
        post["caption"]=commentField.text!
        post["author"]=PFUser.current()!
        
        let imageData = imageView.image!.pngData()//binary objects are stored as URL thus use a "PF file object" is needed
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"]=file
        
        post.saveInBackground(){(success,error) in
            if success{
                self.dismiss(animated: true)
                print("saved!")
            }else{
                print("error!")
            }
        }
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self//(lets me know what they took) when user is done taking a photo call a function that has the photo (for custom view might use "ab foundation" or a 3 party libary)
        picker.allowsEditing = true//presents a second screen to tweek it up
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){//elums ".isSourceTypeAvailable(.)" kida of where you at what enum your expecting.
            picker.sourceType = .camera
        }else{//since the cammera is not availibel in the similator.
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true,completion: nil)
    }
    
    //function bellow helps show the image in the imageView when the picker is finished.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage//dictionary that has image
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage //imageView is what is displayed
        
        dismiss(animated: true,completion:nil)//dissmis camera view once
    }

}
