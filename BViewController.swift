//
//  BViewController.swift
//  ImagepickerTask
//
//  Created by Sekhar Simhadri on 03/02/19.
//  Copyright © 2019 Sekhar Simhadri. All rights reserved.
//

import UIKit
import CoreImage

class BViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UICollectionViewDelegateFlowLayout{
    
    //MARK:- CollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == stickerCollectionView{
        if stickerrow == 0{
            return emotionsArray.count
        }else if stickerrow == 1{
            return stickersArray.count
        }
        }else if collectionView == shadowCollection{
            return colors.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
        if collectionView == stickerCollectionView{
        stickerCollectionView.backgroundColor = UIColor.clear
        cell.contentView.layer.backgroundColor = UIColor.clear.cgColor
        
        if stickerrow == 0{
            cell.stickerCellImage.image = emotionsArray[indexPath.item]
        }else if stickerrow == 1{
        cell.stickerCellImage.image = stickersArray[indexPath.item]
        }
        }
            
        else if collectionView == shadowCollection{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
            cell2.contentView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            cell2.shadowView.backgroundColor = colors[indexPath.item]
            return cell2
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == stickerCollectionView{
            singleStickerV.isHidden = false
            singleStickerClose.isHidden = false
            singleStickerTransform.isHidden = false
            mirroreffectBtn.isHidden = false
        if stickerrow == 0{
            stickerImgV.image = emotionsArray[indexPath.item]
            
        }else if stickerrow == 1{
            stickerImgV.image = stickersArray[indexPath.item]
        }
        }
        else if collectionView == shadowCollection{
            texthere.shadowColor = colors[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == shadowCollection{
            return CGSize(width: 30, height: 30)
        }
        else if collectionView == stickerCollectionView
        {
            return CGSize(width: 50, height: 50)
        }
        return CGSize(width: 30, height: 30)
    }

    //MARK:- IBOutlets
    @IBOutlet var imgvw2 : UIImageView!
    @IBOutlet var scrvw : UIScrollView!
    @IBOutlet var backgroundView : UIView!
    @IBOutlet weak var viewBottomConstraints: NSLayoutConstraint!
    @IBOutlet var animatedView : UIView!
    @IBOutlet var animatingScrlvw : UIScrollView!
    @IBOutlet var brightnesssldr : UISlider!
    @IBOutlet var contrastslider : UISlider!
    @IBOutlet var saturationSldr : UISlider!
    @IBOutlet var texthere : UILabel!
    @IBOutlet var txtfldfortxt : UITextField!
    @IBOutlet var textbtn : UIButton!
    @IBOutlet var donebtn : UIButton!
    @IBOutlet var effectsbtn : UIButton!
    @IBOutlet var contrastbtn : UIButton!
    @IBOutlet var textenterbtn : UIButton!
    @IBOutlet var brightnessbtn : UIButton!
    @IBOutlet var stickerbtn : UIButton!
    @IBOutlet var imgvw1 : UIImageView!
    @IBOutlet var picker : UIPickerView!
    @IBOutlet var pickeronview : UIView!
    @IBOutlet var crossclosee : UIButton!
    @IBOutlet var colorlabel : UILabel!
    @IBOutlet var stylelabel : UILabel!
    @IBOutlet var sizelabel : UILabel!
    @IBOutlet var stickerView : UIView!
    @IBOutlet var StickerScroll : UIScrollView!
    @IBOutlet var imgvw3 : UIImageView!
    @IBOutlet var framescroll : UIScrollView!
    @IBOutlet weak var framescrollOnViewConstraint: NSLayoutConstraint!
    @IBOutlet var stickerCollectionView : UICollectionView!
    @IBOutlet var stickerImgV : UIImageView!
    @IBOutlet var textfonView : UIView!
    @IBOutlet weak var textfonViewConstraint: NSLayoutConstraint!
    @IBOutlet var stickerclose : UIButton!
    @IBOutlet var singleStickerV : UIView!
    @IBOutlet var singleStickerClose : UIButton!
    @IBOutlet var singleStickerTransform : UIButton!
    @IBOutlet var mirroreffectBtn : UIButton!
    @IBOutlet weak var styleLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var sizelabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var textonviewConstraint: NSLayoutConstraint!
    @IBOutlet weak var stickerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var textShadowViewConstraint: NSLayoutConstraint!
    @IBOutlet var textShadowOnView : UIView!
    @IBOutlet var shadowCollection : UICollectionView!
    @IBOutlet var widthStepper : UIStepper!
    @IBOutlet var heightStepper : UIStepper!
    @IBOutlet var shadowSwitch : UISwitch!
    @IBOutlet var shadowWidthLabel : UILabel!
    @IBOutlet var shadowHeightLabel : UILabel!
    @IBOutlet var shadowCollectionLabel : UILabel!
    
    //MARK:- Variables
    var img : UIImage?
    var lastRotation: CGFloat = 0
    var aCIImage = CIImage();
    var contrastFilter: CIFilter!;
    var brightnessFilter: CIFilter!;
    var context = CIContext();
    var outputImage = CIImage();
    var newUIImage = UIImage();
    var stickerrow = 0
    var CIFilterNames = [
    "CIPhotoEffectChrome","CIPhotoEffectFade","CIVignette","CIVignetteEffect",
//    "CIPhotoEffectInstant","CIPhotoEffectNoir","CIPageCurlWithShadowTransition",
//        "CIPhotoEffectTonal","CIPhotoEffectTransfer",
//        "CISepiaTone","CIColorClamp","CIBoxBlur","CIDiscBlur",
//        "CIGaussianBlur","CIMaskedVariableBlur",
//        "CIZoomBlur","CIPhotoEffectProcess","CISepiaTone",
//        "CIPhotoEffectMono",
//        "CIPhotoEffectProcess","CIBumpDistortion","CIBumpDistortionLinear",
//        "CICircularWrap","CIDisplacementDistortion",
//        "CIGlassDistortion","CIGlassLozenge",
//        "CIHoleDistortion","CIPinchDistortion",
//        "CIStretchCrop","CITorusLensDistortion",
//        "CITwirlDistortion","CIVortexDistortion",
//        "CIPerspectiveTransform","CIPerspectiveTransformWithExtent",
//        "CICircularScreen","CICMYKHalftone","CIDotScreen","CIHatchedScreen",
//        "CILineScreen","CISharpenLuminance","CIUnsharpMask","CIBloom",
//        "CICrystallize","CIDepthOfField","CIEdges",
//        "CIEdgeWork","CIGloom","CIHeightFieldFromMask","CIHexagonalPixellate",
//        "CIHighlightShadowAdjust","CILineOverlay","CIPixellate",
        "CIPointillize","CISpotColor","CISpotLight"]
    
    //MARK:- Constants
    let filterButton = UIButton(type: .custom)
    let emotionsArray = [#imageLiteral(resourceName: "classic-emoticons_sleepy-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_kissing-face-with-closed-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_flushed-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_frowning-face-with-open-mouth_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_dizzy-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_relieved-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_pouting-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face-with-open-mouth_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_astonished-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_disappointed-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-throwing-a-kiss_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_kissing-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_miling-face-with-open-mouth-and-cold-sweat_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face-with-smiling-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-savouring-delicious-food_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_tired-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face-with-heart-shaped-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-stuck-out-tongue-and-winking-eye_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_grinning-cat-face-with-smiling-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_anguished-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_kissing-cat-face-with-closed-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_neutral-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face-with-horns_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_fearful-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-medical-mask_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_pensive-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_weary-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_grinning-face-with-smiling-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-without-mouth_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-cat-face-with-heart-shaped-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_expressionless-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-open-mouth_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_unamused-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_grimacing-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-cat-face-with-open-mouth_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_frowning-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_crying-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_crying-cat-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-cold-sweat_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_disappointed-but-relieved-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_kissing-face-with-smiling-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_winking-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_grinning-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-open-mouth-and-cold-sweat_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_cat-face-with-tears-of-joy_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_persevering-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_loudly-crying-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smirking-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_confused-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face-with-open-mouth-and-tightly-closed-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_confounded-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-look-of-triumph_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_cat-face-with-wry-smile_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-screaming-in-fear_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face-with-open-mouth-and-smiling-eyes_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_pouting-cat-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_hushed-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-stuck-out-tongue_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_face-with-tears-of-joy_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_worried-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_smiling-face-with-halo_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_weary-cat-face_simple-ios-blue-gradient_256x256.png"),#imageLiteral(resourceName: "classic-emoticons_angry-face_simple-ios-blue-gradient_256x256.png")]
    let stickersArray = [#imageLiteral(resourceName: "sticker-1.png"),#imageLiteral(resourceName: "sticker2.png"),#imageLiteral(resourceName: "sticker3.png"),#imageLiteral(resourceName: "sticker5.png"),#imageLiteral(resourceName: "sticker6.png"),#imageLiteral(resourceName: "sticker7.png"),#imageLiteral(resourceName: "sticker8.png"),#imageLiteral(resourceName: "sticker9.png"),#imageLiteral(resourceName: "sticker10.png")]
    let colors = [UIColor.black,UIColor.red,UIColor.green,UIColor.blue,UIColor.brown,
                  UIColor.cyan,UIColor.darkGray,UIColor.darkText,
                  UIColor.gray,UIColor.lightGray,UIColor.lightText,UIColor.magenta,
                  UIColor.orange,UIColor.purple,UIColor.white,UIColor.yellow]
    let colorsNames = ["Black","Red","Green","Blue","Brown","Cyan","D-Gray",
                       "D-Text","Gray","L-Gray","L-Text","Magenta","Orange","Purple",
                       "White","Yellow"]
    let framesArray = ["frame3","frame9","frame10","frames3","frames9"]
    let stickericons = ["sticker icon","sticker-1"]
    let filtertypes = ["CICategoryBlur","CICategoryColorAdjustment",
        "CICategoryColorEffect","CICategoryCompositeOperation",
        "CICategoryDistortionEffect","CICategoryGenerator",
        "CICategoryGeometryAdjustment","CICategoryGradient",
        "CICategoryHalftoneEffect","CICategoryReduction","CICategorySharpen",
        "CICategoryStylize","CICategoryTileEffect","CICategoryTransition"]
    let CICategoryBlur = ["CIBoxBlur","CIDiscBlur","CIGaussianBlur",
                          "CIMaskedVariableBlur","CIZoomBlur"]
    let CICategoryColorAdjustment = ["CIColorClamp"]
    let CICategoryColorEffect = ["CIPhotoEffectChrome","CIPhotoEffectFade",
                                 "CIPhotoEffectInstant","CIPhotoEffectTonal",
                                 "CIPhotoEffectTransfer","CISepiaTone",
                                 "CIPhotoEffectMono","CIPhotoEffectNoir",
                                 "CIPhotoEffectProcess","CIVignette",
                                 "CIVignetteEffect",]
    let CICategoryDistortionEffect = ["CIBumpDistortion","CIBumpDistortionLinear","CICircularWrap","CIDisplacementDistortion","CIGlassDistortion","CIGlassLozenge","CIHoleDistortion","CIPinchDistortion","CIStretchCrop","CITorusLensDistortion","CITwirlDistortion","CIVortexDistortion"]
    let CICategoryTransition = ["CIPageCurlWithShadowTransition",]
    let CICategoryGeometryAdjustment = ["CIPerspectiveTransform","CIPerspectiveTransformWithExtent"]
    let CICategoryHalftoneEffect = ["CICircularScreen","CICMYKHalftone","CIDotScreen","CIHatchedScreen","CILineScreen"]
    let CICategorySharpen = ["CISharpenLuminance","CIUnsharpMask"]
    let CICategoryStylize = ["CIBloom","CICrystallize","CIDepthOfField","CIEdges","CIEdgeWork","CIGloom","CIHeightFieldFromMask","CIHexagonalPixellate","CIHighlightShadowAdjust","CILineOverlay","CIPixellate","CIPointillize","CISpotColor","CISpotLight"]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        general()
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollCreation()
    }
    
    //MARK:- Additional Functions
    func general()
    {
        callingGestures()
        scrvw.showsHorizontalScrollIndicator = false
        singleStickerV.backgroundColor = UIColor.clear
        imgvw2.image = img
        scrvw.contentSize = CGSize(width: 700, height: 60)
        brtcntrst()
        imgvw1.addSubview(texthere)
        imgvw2.isHidden = true
        imgvw1.image = img
        pickeronview.layer.borderColor = UIColor.white.cgColor
        pickeronview.layer.borderWidth = 5
        textShadowOnView.layer.borderColor = UIColor.white.cgColor
        textShadowOnView.layer.borderWidth = 5
        shadowCollection.frame = CGRect(x: 199, y: 68, width: self.view.frame.width/2, height: 34)
        shadowWidthLabel.frame = CGRect(x: 10, y: 10, width: self.view.frame.width/7, height: 20)
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 50.0
        let buttonHeight: CGFloat = 50.0
        let gapBetweenButtons: CGFloat = 10
        for i in 0..<stickericons.count{
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = i
            filterButton.addTarget(self, action:#selector(stickersCollection), for: .touchUpInside)
            filterButton.layer.cornerRadius = filterButton.frame.size.width/2
            filterButton.layer.borderColor = UIColor.white.cgColor
            filterButton.layer.borderWidth = 3
            filterButton.clipsToBounds = true
            xCoord +=  buttonWidth + gapBetweenButtons
            filterButton.setImage(UIImage(named: stickericons[i]), for: .normal)
            StickerScroll.addSubview(filterButton)
            StickerScroll.contentSize = CGSize(width:buttonWidth*CGFloat(stickericons.count+(stickericons.count/4)) , height: 50 )
        }
    }

    func callingGestures(){
        imgvw1.clipsToBounds = true
        backgroundView.clipsToBounds = true
        stickerImgV.clipsToBounds = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchedView(sender:)))
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateActionForImage(sender:)))
        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(draggedView2(_:)))
        let pinchGesture2 = UIPinchGestureRecognizer(target: self, action: #selector(pinchedView2(sender:)))
        let rotate2 = UIRotationGestureRecognizer(target: self, action: #selector(rotateActionForImage2(sender:)))
        imgvw1.addGestureRecognizer(panGesture)
        imgvw1.addGestureRecognizer(pinchGesture)
        imgvw1.addGestureRecognizer(rotate)
        texthere.addGestureRecognizer(panGesture2)
        texthere.addGestureRecognizer(pinchGesture2)
        texthere.addGestureRecognizer(rotate2)
    }
    
    func scrollCreation() {
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 50.0
        let buttonHeight: CGFloat = 50.0
        let gapBetweenButtons: CGFloat = 10
        
        for i in 0..<CIFilterNames.count{
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = i
            filterButton.addTarget(self, action:#selector(buttonTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = filterButton.frame.size.width/2
            filterButton.layer.borderColor = UIColor.white.cgColor
            filterButton.layer.borderWidth = 3
            filterButton.clipsToBounds = true
            xCoord +=  buttonWidth + gapBetweenButtons
            
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: self.imgvw2.image!)
            let filter = CIFilter(name: "\(self.CIFilterNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            print(filter as Any)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!);
            filterButton.setBackgroundImage(imageForButton, for: .normal)
                }
            }
            
            animatingScrlvw.addSubview(filterButton)
            animatingScrlvw.contentSize = CGSize(width:buttonWidth*CGFloat(CIFilterNames.count+(CIFilterNames.count/4)) , height: 50 )
        }
    }
    
    func hideanimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.viewBottomConstraints.constant = -250
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func brtcntrst(){
        let aUIImage = imgvw2.image;
        let aCGImage = aUIImage?.cgImage;
        aCIImage = CIImage(cgImage: aCGImage!)
        context = CIContext(options: nil);
        contrastFilter = CIFilter(name: "CIColorControls");
        contrastFilter.setValue(aCIImage, forKey: "inputImage")
        brightnessFilter = CIFilter(name: "CIColorControls");
        brightnessFilter.setValue(aCIImage, forKey: "inputImage")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        UIView.animate(withDuration: 0.5, animations:
            {
                self.textfonViewConstraint.constant = 126
                self.view.layoutIfNeeded()
        }, completion: nil)
        textField.resignFirstResponder()
        texthere.text = txtfldfortxt.text
        scrvw.isHidden = true
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        UIView.animate(withDuration: 0.5, animations:
            {
                self.textfonViewConstraint.constant = 312
                self.view.layoutIfNeeded()
        }, completion: nil)
    return true
    }


    //MARK:- PickerView Related Functions
    let styles = ["AcademyEngravedLetPlain","AlNile","AlNile-Bold",
        "AmericanTypewriter","AmericanTypewriter-Bold",
        "AmericanTypewriter-Condensed","AmericanTypewriter-CondensedBold",
        "AmericanTypewriter-CondensedLight",
        "AmericanTypewriter-Light","AmericanTypewriter-Semibold","AppleColorEmoji",
        "AppleSDGothicNeo-Bold","AppleSDGothicNeo-Light","AppleSDGothicNeo-Medium",
        "AppleSDGothicNeo-Regular","AppleSDGothicNeo-SemiBold",
        "AppleSDGothicNeo-Thin","AppleSDGothicNeo-UltraLight",
        "Arial-BoldItalicMT","Arial-BoldMT","Arial-ItalicMT","ArialMT",
        "ArialHebrew","ArialHebrew-Bold","ArialHebrew-Light","ArialRoundedMTBold",
        "Avenir-Black","Avenir-BlackOblique","Avenir-Book","Avenir-BookOblique",
        "Avenir-Heavy","Avenir-HeavyOblique","Avenir-Light",
        "Avenir-LightOblique","Avenir-Medium","Avenir-MediumOblique",
        "Avenir-Oblique","Avenir-Roman","AvenirNext-Bold",
        "AvenirNext-BoldItalic","AvenirNext-DemiBold",
        "AvenirNext-DemiBoldItalic","AvenirNext-Heavy","AvenirNext-HeavyItalic",
        "AvenirNext-Italic","AvenirNext-Medium","AvenirNext-MediumItalic",
        "AvenirNext-Regular","AvenirNext-UltraLight","AvenirNext-UltraLightItalic",
        "AvenirNextCondensed-Bold","AvenirNextCondensed-BoldItalic",
        "AvenirNextCondensed-DemiBold","AvenirNextCondensed-DemiBoldItalic",
        "AvenirNextCondensed-Heavy","AvenirNextCondensed-HeavyItalic",
        "AvenirNextCondensed-Italic","AvenirNextCondensed-Medium",
        "AvenirNextCondensed-MediumItalic","AvenirNextCondensed-Regular",
        "AvenirNextCondensed-UltraLight","AvenirNextCondensed-UltraLightItalic",
        "Baskerville","Baskerville-Bold","Baskerville-BoldItalic",
        "Baskerville-Italic","Baskerville-SemiBold","Baskerville-SemiBoldItalic",
        "BodoniSvtyTwoITCTT-Bold","BodoniSvtyTwoITCTT-Book",
        "BodoniSvtyTwoITCTT-BookIta","BodoniSvtyTwoOSITCTT-Bold",
        "BodoniSvtyTwoOSITCTT-Book","BodoniSvtyTwoOSITCTT-BookIt",
        "BodoniSvtyTwoSCITCTT-Book","BodoniOrnamentsITCTT","BradleyHandITCTT-Bold",
        "ChalkboardSE-Bold","ChalkboardSE-Light","ChalkboardSE-Regular",
        "Chalkduster","Charter-Black","Charter-BlackItalic",
        "Charter-Bold","Charter-BoldItalic","Charter-Italic",
        "Charter-Roman","Cochin","Cochin-Bold","Cochin-BoldItalic",
        "Cochin-Italic","Copperplate","Copperplate-Bold",
        "Copperplate-Light","Courier","Courier-Bold",
        /*Courier-BoldOblique
        Courier-Oblique
        ---------------------
        *** Courier New ***
        CourierNewPS-BoldItalicMT
        CourierNewPS-BoldMT
        CourierNewPS-ItalicMT
        CourierNewPSMT
        ---------------------
        *** DIN Alternate ***
        DINAlternate-Bold
        ---------------------
        *** DIN Condensed ***
        DINCondensed-Bold
        ---------------------
        *** Damascus ***
        Damascus
        DamascusBold
        DamascusLight
        DamascusMedium
        DamascusSemiBold
        ---------------------
        *** Devanagari Sangam MN ***
        DevanagariSangamMN
        DevanagariSangamMN-Bold
        ---------------------
        *** Didot ***
        Didot
        Didot-Bold
        Didot-Italic
        ---------------------
        *** Euphemia UCAS ***
        EuphemiaUCAS
        EuphemiaUCAS-Bold
        EuphemiaUCAS-Italic
        ---------------------
        *** Farah ***
        Farah
        ---------------------
        *** Futura ***
        Futura-Bold
        Futura-CondensedExtraBold
        Futura-CondensedMedium
        Futura-Medium
        Futura-MediumItalic
        ---------------------
        *** Geeza Pro ***
        GeezaPro
        GeezaPro-Bold
        ---------------------
        *** Georgia ***
        Georgia
        Georgia-Bold
        Georgia-BoldItalic
        Georgia-Italic
        ---------------------
        *** Gill Sans ***
        GillSans
        GillSans-Bold
        GillSans-BoldItalic
        GillSans-Italic
        GillSans-Light
        GillSans-LightItalic
        GillSans-SemiBold
        GillSans-SemiBoldItalic
        GillSans-UltraBold
        ---------------------
        *** Gujarati Sangam MN ***
        GujaratiSangamMN
        GujaratiSangamMN-Bold
        ---------------------
        *** Gurmukhi MN ***
        GurmukhiMN
        GurmukhiMN-Bold
        ---------------------
        *** Heiti SC ***
        ---------------------
        *** Heiti TC ***
        ---------------------
        *** Helvetica ***
        Helvetica
        Helvetica-Bold
        Helvetica-BoldOblique
        Helvetica-Light
        Helvetica-LightOblique
        Helvetica-Oblique
        ---------------------
        *** Helvetica Neue ***
        HelveticaNeue
        HelveticaNeue-Bold
        HelveticaNeue-BoldItalic
        HelveticaNeue-CondensedBlack
        HelveticaNeue-CondensedBold
        HelveticaNeue-Italic
        HelveticaNeue-Light
        HelveticaNeue-LightItalic
        HelveticaNeue-Medium
        HelveticaNeue-MediumItalic
        HelveticaNeue-Thin
        HelveticaNeue-ThinItalic
        HelveticaNeue-UltraLight
        HelveticaNeue-UltraLightItalic
        ---------------------
        *** Hiragino Maru Gothic ProN ***
        HiraMaruProN-W4
        ---------------------
        *** Hiragino Mincho ProN ***
        HiraMinProN-W3
        HiraMinProN-W6
        ---------------------
        *** Hiragino Sans ***
        HiraginoSans-W3
        HiraginoSans-W6
        ---------------------
        *** Hoefler Text ***
        HoeflerText-Black
        HoeflerText-BlackItalic
        HoeflerText-Italic
        HoeflerText-Regular
        ---------------------
        *** Kailasa ***
        Kailasa
        Kailasa-Bold
        ---------------------
        *** Kannada Sangam MN ***
        KannadaSangamMN
        KannadaSangamMN-Bold
        ---------------------
        *** Kefa ***
        Kefa-Regular
        ---------------------
        *** Khmer Sangam MN ***
        KhmerSangamMN
        ---------------------
        *** Kohinoor Bangla ***
        KohinoorBangla-Light
        KohinoorBangla-Regular
        KohinoorBangla-Semibold
        ---------------------
        *** Kohinoor Devanagari ***
        KohinoorDevanagari-Light
        KohinoorDevanagari-Regular
        KohinoorDevanagari-Semibold
        ---------------------
        *** Kohinoor Telugu ***
        KohinoorTelugu-Light
        KohinoorTelugu-Medium
        KohinoorTelugu-Regular
        ---------------------
        *** Lao Sangam MN ***
        LaoSangamMN
        ---------------------
        *** Malayalam Sangam MN ***
        MalayalamSangamMN
        MalayalamSangamMN-Bold
        ---------------------
        *** Marker Felt ***
        MarkerFelt-Thin
        MarkerFelt-Wide
        ---------------------
        *** Menlo ***
        Menlo-Bold
        Menlo-BoldItalic
        Menlo-Italic
        Menlo-Regular
        ---------------------
        *** Mishafi ***
        DiwanMishafi
        ---------------------
        *** Myanmar Sangam MN ***
        MyanmarSangamMN
        MyanmarSangamMN-Bold
        ---------------------
        *** Noteworthy ***
        Noteworthy-Bold
        Noteworthy-Light
        NotoNastaliqUrdu
        NotoSansChakma-Regular
        Optima-Bold
        Optima-BoldItalic
        Optima-ExtraBlack
        Optima-Italic
        Optima-Regular
        OriyaSangamMN
        OriyaSangamMN-Bold
        Palatino-Bold
        Palatino-BoldItalic
        Palatino-Italic
        Palatino-Roman
        Papyrus
        Papyrus-Condensed
        PartyLetPlain
        PingFangHK-Light
        PingFangHK-Medium
        PingFangHK-Regular
        PingFangHK-Semibold*/
        "PingFangHK-Thin","TamilSangamMN","TamilSangamMN-Bold",
        "PingFangHK-Ultralight","PingFangSC-Light","PingFangSC-Medium",
        "PingFangSC-Regular","PingFangSC-Semibold",
        "PingFangSC-Thin","PingFangSC-Ultralight",
        "PingFangTC-Light","PingFangTC-Medium","PingFangTC-Regular",
        "PingFangTC-Semibold","PingFangTC-Thin","PingFangTC-Ultralight",
        "Rockwell-Bold","Rockwell-BoldItalic","Rockwell-Italic","Rockwell-Regular",
        "SavoyeLetPlain","SinhalaSangamMN","SinhalaSangamMN-Bold",
        "SnellRoundhand","SnellRoundhand-Black","SnellRoundhand-Bold","Symbol",
        "Thonburi","Thonburi-Bold","Thonburi-Light","TimesNewRomanPS-BoldItalicMT",
        "TimesNewRomanPS-BoldMT","TimesNewRomanPS-ItalicMT","TimesNewRomanPSMT",
        "Trebuchet-BoldItalic","TrebuchetMS","TrebuchetMS-Bold","TrebuchetMS-Italic",
        "Verdana","Verdana-Bold","Verdana-BoldItalic","Verdana-Italic",
        "ZapfDingbatsITC","Zapfino"
        ]
    let fontSize = [1,2,4,7,11,16,22,29,37,46,56,67,79,92,106,121]
    let fontSizestring = ["1","2","4","7","11","16","22","29","37","46","56","67","79","92","106","121"]
    var stylename = "AcademyEngravedLetPlain"
    var size = 20
    var color = UIColor.black
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        texthere.textColor = color
        texthere.font = UIFont(name: stylename, size: CGFloat(size))
        if component == 0{
            return colors.count
        }else if component == 1{
            return styles.count
        }else if component == 2{
            return fontSize.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return colorsNames[row]
        }else if component == 1{
            return styles[row]
        }else if component == 2{
            return fontSizestring[row]
        }
        return "Nothing"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            color = colors[row]
            texthere.textColor = color
            texthere.font = UIFont(name: stylename, size: CGFloat(size))
        }else if component == 1{
            stylename = styles[row]
            texthere.textColor = color
            texthere.font = UIFont(name: stylename, size: CGFloat(size))
        }else if component == 2{
            size = fontSize[row]
            texthere.textColor = color
            texthere.font = UIFont(name: stylename, size: CGFloat(size))
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0{
            return NSAttributedString(string: colorsNames[row], attributes: [NSAttributedString.Key.foregroundColor: colors[row]])
        }else if component == 1{
            return NSAttributedString(string: styles[row], attributes: [NSAttributedString.Key.font: UIFont(name: styles[row], size: 20)!])
        }else if component == 2{
            return NSAttributedString(string: fontSizestring[row])
        }
        return NSAttributedString(string: "Nothing")
        
    }

    //MARK:- Gesture Actions
    @objc func buttonTapped(sender:UIButton){
        let i = sender as UIButton
        let i2 = i.tag
        print(CIFilterNames[i2])
        img = i.backgroundImage(for: UIControl.State.normal)
        imgvw1.image = img
    }

    @objc func pinchedView(sender:UIPinchGestureRecognizer){
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
    @objc  func draggedView(_ panGesture:UIPanGestureRecognizer){
        let translation = panGesture.translation(in: view)
        panGesture.setTranslation(CGPoint.zero, in: view)
        let imgView = panGesture.view
        imgView?.center = CGPoint(x: (imgView?.center.x)!+translation.x, y: (imgView?.center.y)!+translation.y)
        imgView?.isMultipleTouchEnabled = true
        imgView?.isUserInteractionEnabled = true
    }

    @objc func rotateActionForImage(sender:UIRotationGestureRecognizer){
        let viewDrag = sender.view
        viewDrag?.transform=(viewDrag?.transform.rotated(by:sender.rotation))!
        sender.rotation=0
    }
    
    @objc func pinchedView2(sender:UIPinchGestureRecognizer){
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
    @objc  func draggedView2(_ panGesture:UIPanGestureRecognizer){
        let translation = panGesture.translation(in: view)
        panGesture.setTranslation(CGPoint.zero, in: view)
        let imgView = panGesture.view
        imgView?.center = CGPoint(x: (imgView?.center.x)!+translation.x, y: (imgView?.center.y)!+translation.y)
        imgView?.isMultipleTouchEnabled = true
        imgView?.isUserInteractionEnabled = true
    }
    
    @objc func rotateActionForImage2(sender:UIRotationGestureRecognizer){
        let viewDrag = sender.view
        viewDrag?.transform=(viewDrag?.transform.rotated(by:sender.rotation))!
        sender.rotation=0
    }

    //MARK:- Slider Actions
    func sliderContrastValueChanged(sender: UISlider) {
        brtcntrst()
        contrastFilter.setValue(NSNumber(value: sender.value), forKey: "inputContrast")
        outputImage = contrastFilter.outputImage!;
        let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        newUIImage = UIImage(cgImage: cgimg!)
        imgvw1.image = newUIImage;
        print(contrastslider.value)
    }
    
    func sliderValueChanged(sender: UISlider) {
        brtcntrst()
        brightnessFilter.setValue(NSNumber(value: sender.value), forKey: "inputBrightness");
        outputImage = brightnessFilter.outputImage!;
        let imageRef = context.createCGImage(outputImage, from: outputImage.extent)
        newUIImage = UIImage(cgImage: imageRef!)
        imgvw1.image = newUIImage;
        print(brightnesssldr.value)
    }
    
    //MARK:- Button Actions
    @IBAction func Effects()
    {
        imgvw1.image = imgvw2.image
        texthere.isHidden = true
        txtfldfortxt.isHidden = true
        textbtn.isHidden = true
        picker.isHidden = true
        contrastslider.isHidden = true
        brightnesssldr.isHidden = true
        donebtn.isHidden = false
        saturationSldr.isHidden = true
        pickeronview.isHidden = true
        crossclosee.isHidden = true
        UIView.animate(withDuration: 0.5, animations:
            {
            self.viewBottomConstraints.constant = 2
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func close()
    {
        hideanimation()
        imgvw1.image = imgvw2.image
        donebtn.isHidden = true
    }
    
    @IBAction func done(){
        singleStickerClose.isHidden = true
        singleStickerTransform.isHidden = true
        donebtn.isHidden = true
        txtfldfortxt.isHidden = true
        textbtn.isHidden = true
        contrastslider.isHidden = true
        brightnesssldr.isHidden = true
        saturationSldr.isHidden = true
        hideanimation()
        picker.isHidden = true
        pickeronview.isHidden = true
        crossclosee.isHidden = true
        scrvw.isHidden = false
        stickerView.isHidden = true
        textfonView.isHidden = true
        stickerclose.isHidden = true
        mirroreffectBtn.isHidden = true
        UIGraphicsBeginImageContext(self.backgroundView.bounds.size)
        self.backgroundView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let sourceImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imgvw1.image = sourceImage
        imgvw2.image = sourceImage
        stickerImgV.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.textShadowViewConstraint.constant = 1100
            self.framescrollOnViewConstraint.constant = -500
            self.view.layoutIfNeeded()
            }, completion: nil)

    }
    
    @IBAction func save()
    {
        UIGraphicsBeginImageContext(self.backgroundView.bounds.size)
        self.backgroundView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let sourceImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(sourceImage!, nil, nil, nil)
        let alertvw = UIAlertController(title: "Effects World", message: "Your image has been saved to Photo Library", preferredStyle: .alert)
        alertvw.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(ACTION) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertvw, animated: true, completion: nil)
    }
    
    @IBAction func brightness(){
        imgvw1.image = imgvw2.image
        hideanimation()
        texthere.isHidden = true
        txtfldfortxt.isHidden = true
        textbtn.isHidden = true
        contrastslider.isHidden = true
        donebtn.isHidden = false
        brightnesssldr.isHidden = false
        saturationSldr.isHidden = true
        picker.isHidden = true
        pickeronview.isHidden = true
        crossclosee.isHidden = true
    }
    
    @IBAction func contrast(){
        imgvw1.image = imgvw2.image
        hideanimation()
        texthere.isHidden = true
        txtfldfortxt.isHidden = true
        textbtn.isHidden = true
        brightnesssldr.isHidden = true
        donebtn.isHidden = false
        contrastslider.isHidden = false
        saturationSldr.isHidden = true
        picker.isHidden = true
        pickeronview.isHidden = true
        crossclosee.isHidden = true
    }
    
    @IBAction func saturation(){
        donebtn.isHidden = false
        let ciimage = CIImage.init(cgImage: imgvw2.image!.cgImage!)
        let filter = CIFilter.init(name: "CIColorControls")
        filter?.setValue(ciimage, forKey: kCIInputImageKey)
        filter?.setValue(saturationSldr.value, forKey: kCIInputSaturationKey)
        let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let cgimage = CIContext.init(options: nil).createCGImage(result, from: result.extent)
        let image = UIImage.init(cgImage: cgimage!)
        imgvw1.image = image
        picker.isHidden = true
    }
    
    @IBAction func brtnssldr(){
        sliderValueChanged(sender: brightnesssldr)
    }
    
    @IBAction func cntrstsldr(){
        sliderContrastValueChanged(sender: contrastslider)
    }
    
    @IBAction func text(){
        imgvw1.image = imgvw2.image
        pickeronview.isHidden = false
        crossclosee.isHidden = false
        donebtn.isHidden = false
        texthere.isHidden = false
        txtfldfortxt.isHidden = false
        textbtn.isHidden = false
        picker.isHidden = false
        brightnesssldr.isHidden = true
        contrastslider.isHidden = true
        saturationSldr.isHidden = true
        hideanimation()
        scrvw.isHidden = true
        textfonView.isHidden = false
        UIView.animate(withDuration: 0.8, animations: {
            self.textonviewConstraint.constant = 126
            self.textShadowViewConstraint.constant = 0
            self.view.layoutIfNeeded()
            })
        colorlabel.frame = CGRect(x: (pickeronview.frame.width/7)-12, y: 5, width: pickeronview.frame.width/7, height: 23)
        stylelabel.frame = CGRect(x: 3*(pickeronview.frame.width/7), y: 5, width: pickeronview.frame.width/7, height: 23)
        sizelabel.frame = CGRect(x: (5*(pickeronview.frame.width/7))+10, y: 5, width: pickeronview.frame.width/7, height: 23)
        texthere.textColor = color
        texthere.font = UIFont(name: stylename, size: CGFloat(size))
    }
    @IBAction func shadowSwitchAction(){
        if shadowSwitch.isOn == true
        {
            texthere.shadowOffset = CGSize(width: widthStepper.value, height: heightStepper.value)
            texthere.shadowColor = UIColor.black
            heightStepper.isHidden = false
            widthStepper.isHidden = false
            shadowCollection.isHidden = false
            shadowWidthLabel.isHidden = false
            shadowHeightLabel.isHidden = false
            shadowCollectionLabel.isHidden = false
        }
        else if shadowSwitch.isOn == false
        {
            heightStepper.isHidden = true
            widthStepper.isHidden = true
            shadowCollection.isHidden = true
            shadowWidthLabel.isHidden = true
            shadowHeightLabel.isHidden = true
            shadowCollectionLabel.isHidden = true
            texthere.shadowColor = UIColor.clear
        }
    }

    @IBAction func pickerclose(){
        crossclosee.isHidden = true
        scrvw.isHidden = false
        texthere.isHidden = true
        donebtn.isHidden = true
        UIView.animate(withDuration: 0.6, animations:
            {
                self.textonviewConstraint.constant = -200
                self.textShadowViewConstraint.constant = 1100
                self.view.layoutIfNeeded()
        }, completion: nil)
        txtfldfortxt.resignFirstResponder()
    }
    
    @IBAction func enter(){
        texthere.text = txtfldfortxt.text
        UIView.animate(withDuration: 0.5, animations:
            {
                self.textfonViewConstraint.constant = 126
                self.view.layoutIfNeeded()
        }, completion: nil)
        txtfldfortxt.resignFirstResponder()
    }

    @IBAction func saturationBtn(){
        imgvw1.image = imgvw2.image
        hideanimation()
        donebtn.isHidden = false
        saturationSldr.isHidden = false
        texthere.isHidden = true
        txtfldfortxt.isHidden = true
        textbtn.isHidden = true
        brightnesssldr.isHidden = true
        contrastslider.isHidden = true
        picker.isHidden = true
        pickeronview.isHidden = true
        crossclosee.isHidden = true
    }
    
    @IBAction func stickers(){
        imgvw1.image = imgvw2.image
        hideanimation()
        saturationSldr.isHidden = true
        texthere.isHidden = true
        txtfldfortxt.isHidden = true
        textbtn.isHidden = true
        brightnesssldr.isHidden = true
        contrastslider.isHidden = true
        picker.isHidden = true
        pickeronview.isHidden = true
        crossclosee.isHidden = true
        stickerView.isHidden = false
        stickerCollectionView.isHidden = false
        donebtn.isHidden = false
        stickerImgV.isHidden = false
        stickerclose.isHidden = false
        UIView.animate(withDuration: 0.5, animations:
            {
                self.stickerViewConstraint.constant = 0
                self.view.layoutIfNeeded()
        }, completion: nil)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchedView(sender:)))
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateActionForImage(sender:)))
        singleStickerV.addGestureRecognizer(panGesture)
        singleStickerV.addGestureRecognizer(pinchGesture)
        singleStickerV.addGestureRecognizer(rotate)
    }
    
    @IBAction func sticersclose(){
        stickerImgV.isHidden = true
        donebtn.isHidden = true
        singleStickerV.isHidden = true
        singleStickerClose.isHidden = true
        singleStickerTransform.isHidden = true
        mirroreffectBtn.isHidden = true
        UIView.animate(withDuration: 0.5, animations:
            {
                self.stickerViewConstraint.constant = -400
                self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func singleStickerCloseA(){
        singleStickerV.isHidden = true
        singleStickerClose.isHidden = true
        singleStickerTransform.isHidden = true
        mirroreffectBtn.isHidden = true
    }
    
    @IBAction func singlestickerRotation(){
        UIView.animate(withDuration: 1, animations:{
            self.singleStickerV.transform = self.singleStickerV.transform.rotated(by: CGFloat(Double.pi/2))
            })
    }
    
    @IBAction func mirror(){
        UIView.animate(withDuration: 1, animations: {
            self.singleStickerV.transform = self.singleStickerV.transform.scaledBy(x: -1, y: 1)
        })
    }
    
    @IBAction func closeEditor(){
        let alert = UIAlertController(title: "Are You Sure", message: "Your changes will be discard", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(ACTION) in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func stickersCollection(sender: UIButton){
        let i = sender.tag
        stickerrow = i
        stickerCollectionView.reloadData()
    }
    
    @objc func frame(sender: UIButton){
        let i = sender.tag
        imgvw3.image = UIImage(named: framesArray[i])
        print(framesArray[i])
    }
    
    @IBAction func shadowWisth(){
        texthere.shadowOffset = CGSize(width: widthStepper.value, height: heightStepper.value)

    }
    
    @IBAction func frames(){
        UIView.animate(withDuration: 0.5, animations: {
            self.framescrollOnViewConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        imgvw1.image = imgvw2.image
        hideanimation()
        saturationSldr.isHidden = true
        brightnesssldr.isHidden = true
        contrastslider.isHidden = true
        donebtn.isHidden = false
        framescroll.layer.borderColor = UIColor.white.cgColor
        framescroll.layer.borderWidth = 3
        framescroll.layer.opacity = 4
        imgvw3.isHidden = false
        var xCoord: CGFloat = 8
        let yCoord: CGFloat = 8
        let buttonWidth:CGFloat = 65.0
        let buttonHeight: CGFloat = 65.0
        let gapBetweenButtons: CGFloat = 15
        for i in 0..<framesArray.count{
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = i
            filterButton.addTarget(self, action:#selector(frame), for: .touchUpInside)
            filterButton.layer.borderColor = UIColor.lightGray.cgColor
            filterButton.layer.borderWidth = 3
            filterButton.clipsToBounds = true
            xCoord +=  buttonWidth + gapBetweenButtons
            filterButton.setImage(UIImage(named: framesArray[i]), for: .normal)
            framescroll.addSubview(filterButton)
            framescroll.contentSize = CGSize(width:buttonWidth*CGFloat(framesArray.count+(framesArray.count/3)) , height: 70 )
        }
    }
    
    @IBAction func framesClose(){
        UIView.animate(withDuration: 0.5, animations: {
            self.framescrollOnViewConstraint.constant = -500
            self.view.layoutIfNeeded()
        }, completion: nil)
        donebtn.isHidden = true
        imgvw3.isHidden = true
    }
}
