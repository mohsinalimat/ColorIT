//
//  WhellController.swift
//  ColoringBook
//
//  Created by MacBook Pro on 12/27/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

import UIKit

var palette = 1
class WhellController: UIViewController {
    
    
    
    
    var imageView = FloodFillImageView()
    var colorWheel: CircularColor!
    @IBOutlet weak var bottomView: UIView!
    //@IBOutlet weak var imageSelector: UIImageView!
    @IBOutlet weak var colorPick: ColorPick!
    @IBOutlet weak var colorView: ColorView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var labelPalNum: UILabel!
    @IBOutlet weak var labelPalName: UILabel!
    var ButtonTapped = false
    var angle: CGFloat = 0.0
    var selectedColor: UIColor = UIColor.red
    var animAngle:CGFloat = 0.0
    var tapped:Bool = false
    var previousPos:CGPoint = CGPoint(x: 0, y: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        //colorView.layer.cornerRadius = 100
        colorView.colorArray.append(UIColor.red)
        colorView.colorArray.append(UIColor.green)
        colorView.colorArray.append(UIColor.orange)
        colorView.colorArray.append(UIColor.yellow)
        colorView.colorArray.append(UIColor.blue)
        colorView.colorArray.append(UIColor.brown)
        colorView.colorArray.append(UIColor.magenta)
        colorView.colorArray.append(UIColor.purple)
            
            
            imageView.newcolor = selectedColor
    }
    override func viewWillAppear(_ animated: Bool) {
        //----------------Reset----------
        if generatedWheels.count==0&&palette>80{
            palette=1
        }
        //-----------------------------
        if palette==1{
            colorPaletteSelection(a: "#655f47", b: "#d74958", c: "#b5dcb9", d: "#6bbd99", e: "#7b8977", f: "#f9e393", g: "#c3aa5b", h: "#b89a2d")
        }
        else if palette==2{
            colorPaletteSelection(a: "#83ddff", b: "#3aa952", c: "#46d255", d: "#62f471", e: "#baffc1", f: "#414643", g: "#08658b", h: "#64c0e6")
        }
        else if palette==3{
            colorPaletteSelection(a: "#ffffff", b: "#f3f3f3", c: "#dadada", d: "#c9c9c9", e: "#b0b0b0", f: "#878787", g: "#5a5a5a", h: "#000000")
        }
        else if palette==4{
            colorPaletteSelection(a: "#b44221", b: "#f3673e", c: "#ffc752", d: "#ccc75e", e: "#78c9a3", f: "#43b7db", g: "#408bcd", h: "#94638e")
        }
        else if palette==5{
            colorPaletteSelection(a: "#f6e784", b: "#f02970", c: "#bd258e", d: "#ffdc00", e: "#ef8b49", f: "#e2e7e8", g: "#a21d6d", h: "#2f0f4b")
        }
        else if palette==6{
            colorPaletteSelection(a: "#8ebdb6", b: "#ffe7e4", c: "#f8a8b8", d: "#2e4473", e: "#ade8e3", f: "#fc708c", g: "#27a7d6", h: "#e6dbe1")
        }
        else if palette==7{
            colorPaletteSelection(a: "#bdf6ff", b: "#76f2ff", c: "#54bcff", d: "#3a91ff", e: "#4a90e2", f: "#11a9bd", g: "#0058be", h: "#0e298b")
        }
        else if palette==8{
            colorPaletteSelection(a: "#ece9e2", b: "#770810", c: "#bcaf9e", d: "#e67238", e: "#7f4632", f: "#403b35", g: "#c3343e", h: "#a32029")
        }
        else if palette==9{
            colorPaletteSelection(a: "#fce8c5", b: "#fffedd", c: "#fc9998", d: "#ffdabd", e: "#ffa900", f: "#9fd6cc", g: "#4d4f4e", h: "#a3997f")
        }
        else if palette==10{
            colorPaletteSelection(a: "#930862", b: "#228bff", c: "#a5e22f", d: "#d643f9", e: "#ffcd18", f: "#047f91", g: "#28e3ff", h: "#ff6ecc")
        }
        else if palette==11{
            colorPaletteSelection(a: "#d7dbde", b: "#dbb99d", c: "#a8a3aa", d: "#71666c", e: "#a48b84", f: "#c7c0ba", g: "#b2a9a0", h: "#d9c9ba")
        }
        else if palette==12{
            colorPaletteSelection(a: "#417d69", b: "#71c592", c: "#ead889", d: "#5397c6", e: "#f3966c", f: "#c05067", g: "#9260b8", h: "#e477a3")
        }
        else if palette==13{
            colorPaletteSelection(a: "#a2ae18", b: "#556270", c: "#4ecdc4", d: "#c7f464", e: "#ff6b6b", f: "#c44d58", g: "#a1212a", h: "#dfff99")
        }
        else if palette==14{
            colorPaletteSelection(a: "#d0a86a", b: "#b18c75", c: "#987252", d: "#865436", e: "#917534", f: "#854200", g: "#5d1913", h: "#401d09")
        }
        else if palette==15{
            colorPaletteSelection(a: "#ea848b", b: "#774f38", c: "#e08e79", d: "#f1d4af", e: "#ece5ce", f: "#c5e0dc", g: "#9cd6ce", h: "#ffa8ae")
        }
        else if palette==16{
            colorPaletteSelection(a: "#222548", b: "#bfac9d", c: "#c7d969", d: "#ddee86", e: "#548798", f: "#6db9d1", g: "#4a4c61", h: "#383a51")
        }
        else if palette==17{
            colorPaletteSelection(a: "#fac8bf", b: "#90c5a9", c: "#f8e1b5", d: "#f98a5f", e: "#cccccc", f: "#698d9d", g: "#466675", h: "#775ca3")
        }
        else if palette==18{
            colorPaletteSelection(a: "#ddded9", b: "#4b8c88", c: "#aca9a2", d: "#86a599", e: "#677c71", f: "#b0cfcd", g: "#6b8a88", h: "#4e6a68")
        }
        else if palette==19{
            colorPaletteSelection(a: "#e05a47", b: "#f9be44", c: "#e478a4", d: "#d53049", e: "#1daadf", f: "#72503e", g: "#165830", h: "#c1d979")
        }
        else if palette==20{
            colorPaletteSelection(a: "#ffe1b5", b: "#ff9800", c: "#ff7700", d: "#ce2153", e: "#aaa8ff", f: "#f8bee8", g: "#ce6499", h: "#9b3166")
        }
        else if palette==21{
            colorPaletteSelection(a: "#8dc9e5", b: "#ceefff", c: "#658879", d: "#97a88f", e: "#7ba395", f: "#6b969d", g: "#cadadd", h: "#a7c0c8")
        }
        else if palette==22{
            colorPaletteSelection(a: "#6a0c33", b: "#ff5a39", c: "#f3412f", d: "#d53825", e: "#682421", f: "#fb2b75", g: "#b91d55", h: "#a01044")
        }
        else if palette==23{
            colorPaletteSelection(a: "#d9d9d9", b: "#ff642f", c: "#ffe100", d: "#38c5ea", e: "#2f81de", f: "#c32a00", g: "#000000", h: "#535353")
        }
        else if palette==24{
            colorPaletteSelection(a: "#e94c6f", b: "#aa2159", c: "#56102c", d: "#5a6962", e: "#009c98", f: "#7ec2ab", g: "#c6d6cc", h: "#fdf300")
        }
        else if palette==25{
            colorPaletteSelection(a: "#f9fbba", b: "#ccc51b", c: "#fee600", d: "#ffac00", e: "#ef5a28", f: "#ff432e", g: "#b9206f", h: "#3a0c55")
        }
        else if palette==26{
            colorPaletteSelection(a: "#265d1d", b: "#69d2e7", c: "#a7dbd8", d: "#e0e4cc", e: "#f38630", f: "#fa6900", g: "#7ec941", h: "#aee085")
        }
        else if palette==27{
            colorPaletteSelection(a: "#801144", b: "#ff2288", c: "#8d55ad", d: "#59376d", e: "#cf7bff", f: "#188c9f", g: "#12616c", h: "#22e1ff")
        }
        else if palette==28{
            colorPaletteSelection(a: "#d1ecb2", b: "#b4ed76", c: "#a5ca7f", d: "#80f500", e: "#63c500", f: "#559f00", g: "#457515", h: "#2a440c")
        }
        else if palette==29{
            colorPaletteSelection(a: "#987c7e", b: "#8d8c8d", c: "#544c4f", d: "#bcc1cd", e: "#000505", f: "#f8f8f8", g: "#d5c8c9", h: "#b6a3a6")
        }
        else if palette==30{
            colorPaletteSelection(a: "#ffee4a", b: "#ffc501", c: "#fe9600", d: "#ff4605", e: "#c91414", f: "#aee72c", g: "#77477e", h: "#03001c")
        }
        else if palette==31{
            colorPaletteSelection(a: "#fcebb7", b: "#f0a830", c: "#f07818", d: "#d65c37", e: "#5e412f", f: "#68727b", g: "#6991ab", h: "#78c0a8")
        }
        else if palette==32{
            colorPaletteSelection(a: "#b04cbc", b: "#8c867a", c: "#ab9f77", d: "#8b628a", e: "#a879af", f: "#b4a3cf", g: "#6822d1", h: "#4101a1")
        }
        else if palette==33{
            colorPaletteSelection(a: "#ffeca7", b: "#cb964f", c: "#da6339", d: "#7e301e", e: "#5a2338", f: "#928744", g: "#f29933", h: "#a77872")
        }
        else if palette==34{
            colorPaletteSelection(a: "#ffd9f3", b: "#322e7d", c: "#d2aac5", d: "#d9d2e1", e: "#7a647e", f: "#9e7ae7", g: "#7a65d8", h: "#545098")
        }
        else if palette==35{
            colorPaletteSelection(a: "#fffee4", b: "#f7fdb6", c: "#d9f19f", d: "#acde8a", e: "#75c776", f: "#3dac5a", g: "#1c8540", h: "#004628")
        }
        else if palette==36{
            colorPaletteSelection(a: "#99d200", b: "#00c0ff", c: "#80e0ff", d: "#809eff", e: "#285bff", f: "#ff9ff5", g: "#ff14a1", h: "#adff81")
        }
        else if palette==37{
            colorPaletteSelection(a: "#f9f2de", b: "#4f4132", c: "#e96574", d: "#d64834", e: "#a43f3d", f: "#826447", g: "#a69481", h: "#756655")
        }
        else if palette==38{
            colorPaletteSelection(a: "#8f9283", b: "#ead889", c: "#f3966c", d: "#e3644e", e: "#9ac086", f: "#7b9fb1", g: "#5397c6", h: "#417d69")
        }
        else if palette==39{
            colorPaletteSelection(a: "#c85dec", b: "#d1f2a5", c: "#effab4", d: "#ffc48c", e: "#ff9f80", f: "#f56991", g: "#de4770", h: "#e9a8ff")
        }
        else if palette==40{
            colorPaletteSelection(a: "#e0c572", b: "#bda53b", c: "#b0856d", d: "#ad6531", e: "#9d9d93", f: "#878f9d", g: "#6c6747", h: "#342f2b")
        }
        else if palette==41{
            colorPaletteSelection(a: "#fdf4d1", b: "#ff0134", c: "#ff6701", d: "#ff8000", e: "#ffa601", f: "#fbce11", g: "#ffe601", h: "#fce691")
        }
        else if palette==42{
            colorPaletteSelection(a: "#f2fdd9", b: "#cfeabf", c: "#f7e7d2", d: "#f8bab4", e: "#aad198", f: "#005557", g: "#004e7f", h: "#004d9a")
        }
        else if palette==43{
            colorPaletteSelection(a: "#00c4e9", b: "#5eff63", c: "#00dd00", d: "#ffea00", e: "#ff9b14", f: "#ff5058", g: "#ff00aa", h: "#9b03fc")
        }
        else if palette==44{
            colorPaletteSelection(a: "#f7fcef", b: "#cbecc4", c: "#a6deb4", d: "#78ccc4", e: "#48b3d5", f: "#238bc0", g: "#0066ae", h: "#023e83")
        }
        else if palette==45{
            colorPaletteSelection(a: "#f7d286", b: "#f99d37", c: "#f67b29", d: "#fcc74b", e: "#ef9c2d", f: "#eb7a35", g: "#f25218", h: "#cb561f")
        }
        else if palette==46{
            colorPaletteSelection(a: "#7e1f5b", b: "#2a0c44", c: "#633669", d: "#f6d58a", e: "#fae6bd", f: "#e88d85", g: "#dc437d", h: "#a04e6b")
        }
        else if palette==47{
            colorPaletteSelection(a: "#3075ff", b: "#c7daff", c: "#96b9ff", d: "#f7cbc9", e: "#ffadd2", f: "#b2869a", g: "#542c3c", h: "#35111f")
        }
        else if palette==48{
            colorPaletteSelection(a: "#9dded4", b: "#ffa979", c: "#f48fa1", d: "#d792e1", e: "#f45576", f: "#ffcd6c", g: "#ffe384", h: "#8b95cb")
        }
        else if palette==49{
            colorPaletteSelection(a: "#b31227", b: "#014a89", c: "#f5f3ee", d: "#2372e8", e: "#fe573d", f: "#878da3", g: "#b8c6dd", h: "#dddadd")
        }
        else if palette==50{
            colorPaletteSelection(a: "#f68581", b: "#7dffc0", c: "#0c9674", d: "#d11b5f", e: "#fcad32", f: "#ffffa0", g: "#ffde96", h: "#ffb996")
        }
        else if palette==51{
            colorPaletteSelection(a: "#d4d4d4", b: "#68dbdc", c: "#549ed7", d: "#d1b2e0", e: "#fcb9c5", f: "#adc4aa", g: "#e7faa5", h: "#c3d680")
        }
        else if palette==52{
            colorPaletteSelection(a: "#0480ff", b: "#00fcec", c: "#10a9a9", d: "#01535b", e: "#ffc24e", f: "#ef4102", g: "#0042bd", h: "#022b90")
        }
        else if palette==53{
            colorPaletteSelection(a: "#fff7f3", b: "#fee0dd", c: "#fdc5bf", d: "#fc9eb5", e: "#f965a1", f: "#df2d98", g: "#b0217f", h: "#7b1978")
        }
        else if palette==54{
            colorPaletteSelection(a: "#24ae68", b: "#ecd078", c: "#d95b43", d: "#c02942", e: "#542437", f: "#53777a", g: "#0c5b63", h: "#29b5c3")
        }
        else if palette==55{
            colorPaletteSelection(a: "#d9dfe9", b: "#503373", c: "#f9d946", d: "#fc9f0e", e: "#7085c6", f: "#6675b4", g: "#604fe1", h: "#783cc0")
        }
        else if palette==56{
            colorPaletteSelection(a: "#feb0ff", b: "#cd8ae3", c: "#b725ff", d: "#6b01c9", e: "#f873ee", f: "#e46098", g: "#a80abf", h: "#9d1072")
        }
        else if palette==57{
            colorPaletteSelection(a: "#bd10e0", b: "#4a90e2", c: "#50e3c2", d: "#b8e986", e: "#61f848", f: "#fff200", g: "#ffa900", h: "#ff7000")
        }
        else if palette==58{
            colorPaletteSelection(a: "#f76834", b: "#f05e57", c: "#483620", d: "#363636", e: "#83683b", f: "#a68f59", g: "#84bf17", h: "#b8be1c")
        }
        else if palette==59{
            colorPaletteSelection(a: "#857f81", b: "#90ba6d", c: "#70a8ff", d: "#8c58ad", e: "#fdce41", f: "#fe9458", g: "#eb6050", h: "#f298bb")
        }
        else if palette==60{
            colorPaletteSelection(a: "#f3e3e9", b: "#e92734", c: "#f3a3b3", d: "#e4394a", e: "#ff6f8c", f: "#e65662", g: "#b28450", h: "#d6ac7d")
        }
        else if palette==61{
            colorPaletteSelection(a: "#ffadad", b: "#ff6399", c: "#e26161", d: "#e01e59", e: "#f81c51", f: "#ff0000", g: "#dc003f", h: "#bd2d2d")
        }
        else if palette==62{
            colorPaletteSelection(a: "#26284b", b: "#00545b", c: "#00c481", d: "#a9db5a", e: "#fcc035", f: "#f16a25", g: "#f02540", h: "#a3275f")
        }
        else if palette==63{
            colorPaletteSelection(a: "#e0ffb3", b: "#00bfbf", c: "#31797d", d: "#2a2f36", e: "#fcbd7c", f: "#f09965", g: "#4aba8a", h: "#420e3b")
        }
        else if palette==64{
            colorPaletteSelection(a: "#715031", b: "#feebdd", c: "#f8d7c4", d: "#f5c7a5", e: "#eab186", f: "#e0ac7d", g: "#cb8c56", h: "#845437")
        }
        else if palette==65{
            colorPaletteSelection(a: "#7595bf", b: "#9cbcd9", c: "#d2a97d", d: "#ffaa5c", e: "#da727e", f: "#ac6c82", g: "#685c79", h: "#455c7b")
        }
        else if palette==66{
            colorPaletteSelection(a: "#e8b81a", b: "#ffa200", c: "#db3440", d: "#982395", e: "#0187cb", f: "#28abe3", g: "#25a8ac", h: "#20da9b")
        }
        else if palette==67{
            colorPaletteSelection(a: "#802829", b: "#20b1ff", c: "#78a306", d: "#546f09", e: "#c2ff0a", f: "#6c551d", g: "#fec53a", h: "#fd9f09")
        }
        else if palette==68{
            colorPaletteSelection(a: "#ff4084", b: "#f63327", c: "#f59d21", d: "#ffe100", e: "#27b320", f: "#38c5ea", g: "#2f81de", h: "#712fde")
        }
        else if palette==69{
            colorPaletteSelection(a: "#69d2e7", b: "#a1d7d9", c: "#a8dbdc", d: "#bfe1bf", e: "#e0e4cc", f: "#fdd059", g: "#f48631", h: "#f96900")
        }
        else if palette==70{
            colorPaletteSelection(a: "#c8e18d", b: "#af608e", c: "#d384af", d: "#ffa962", e: "#ffde78", f: "#cec9ba", g: "#7f7f7f", h: "#e3f3be")
        }
        else if palette==71{
            colorPaletteSelection(a: "#e2d893", b: "#a79e65", c: "#73afb7", d: "#609da0", e: "#a68572", f: "#73503c", g: "#591e22", h: "#2c2302")
        }
        else if palette==72{
            colorPaletteSelection(a: "#d79c8c", b: "#ef9950", c: "#f17d80", d: "#747496", e: "#6d8671", f: "#69a8ad", g: "#28bd9b", h: "#92dbdf")
        }
        else if palette==73{
            colorPaletteSelection(a: "#1f312e", b: "#fd9118", c: "#ffae22", d: "#ffc800", e: "#f7e88e", f: "#007966", g: "#009979", h: "#3a4a47")
        }
        else if palette==74{
            colorPaletteSelection(a: "#3c2e28", b: "#785c50", c: "#967264", d: "#b48a78", e: "#d2a18c", f: "#f0b8a0", g: "#ffceb4", h: "#ffe5c8")
        }
        else if palette==75{
            colorPaletteSelection(a: "#bff073", b: "#82aa30", c: "#0dc9f8", d: "#4d6684", e: "#7f7f7f", f: "#3d3d3d", g: "#ef5b47", h: "#e74701")
        }
        else if palette==76{
            colorPaletteSelection(a: "#e46559", b: "#d2ebe6", c: "#7dc4c4", d: "#50a7b4", e: "#59506e", f: "#c6c9a0", g: "#6e5c50", h: "#e48759")
        }
        else if palette==77{
            colorPaletteSelection(a: "#e0c378", b: "#c08220", c: "#8d5100", d: "#553000", e: "#cbeac6", f: "#95ce7d", g: "#3c972f", h: "#006604")
        }
        else if palette==78{
            colorPaletteSelection(a: "#fed59a", b: "#ffbc80", c: "#f16441", d: "#fe8d52", e: "#d6c75b", f: "#9d9d7e", g: "#b50000", h: "#800000")
        }
        else if palette==79{
            colorPaletteSelection(a: "#f1f1f1", b: "#c3cad4", c: "#7cbfd0", d: "#0f7c7f", e: "#b48954", f: "#e80d0b", g: "#980106", h: "#519e02")
        }
        else if palette==80{
            colorPaletteSelection(a: "#f4ffad", b: "#f8ff54", c: "#ffc000", d: "#fef29b", e: "#fff250", f: "#f8e71c", g: "#ceda47", h: "#daca00")
        }
        else{
            
            //custom generated wheels
            
            for i in 0..<generatedWheels.count{
                
                if (Int64)(palette-1) == generatedWheels[i].number
                {
                    let wheel = generatedWheels[i]
                    colorPaletteSelection(a: wheel.col1, b: wheel.col2, c: wheel.col3, d: wheel.col4, e: wheel.col5, f: wheel.col6, g: wheel.col7, h: wheel.col8)
                }
                
                
            }
            
            /*colorPaletteSelection(a: "#801144", b: "#ff2288", c: "#8d55ad", d: "#59376d", e: "#cf7bff", f: "#188c9f", g: "#12616c", h: "#22e1ff")*/
        }
        if palette <= 80 {
            let text = try! String(contentsOfFile: Bundle.main.path(forResource: "Color_Palette_Name", ofType: "txt")!) // Reading File
            let lineArray = text.components(separatedBy: "\n") // Separating Lines
            labelPalName.text = "\(lineArray[palette-1])"
        }
        else{
            labelPalName.text = "\(generatedWheels[palette-81].name)"
        }
        if (labelPalName.text?.characters.count)!<=9{
            labelPalName.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        }
        else{
            labelPalName.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        }
        labelPalNum.text = "\(palette)"
        ButtonTapped=false
        selectedColor = colorView.colorArray[0]
        imageView.newcolor = selectedColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tapped=true
        if let touch = touches.first {
            let position = touch.location(in: self.view)
            print("POSITION: \(position)")
            let target = colorView.center
            print("TARGET: \(target)")
            angle = atan2(target.y - position.y, target.x - position.x)
            print("ANGLE: \(angle)")
            //angle = atan2(self.view.transform.a, self.view.transform.b) + atan2(self.colorView.transform.a, self.colorView.transform.b);
            
            //let position = touch.location(in: self.view)
            let distance = (pow(colorView.center.x - position.x,2) + pow(colorView.center.y - position.y,2))
            if distance < pow(80/2,2){
                UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                    
                    self.colorView.transform = self.colorView.transform.rotated(by: 2)
                    
                }, completion:nil)
                
            }
            
        }
        
        print("ANGLE: \(angle)")
        
        UIView.animate(withDuration: 0.3, animations: {
            self.middleView.transform = self.middleView.transform.scaledBy(x: 1.3, y: 1.3)
        }, completion:{(finished: Bool) in
            UIView.animate(withDuration: 0.2, animations: {
                self.middleView.transform = self.middleView.transform.scaledBy(x: 0.76923, y: 0.76923)
            })
        })
        
        
    }
    /*override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     tapped=false
     if let touch = touches.first {
     let position = touch.location(in: self.view)
     
     let target = colorView.center
     
     angle = atan2(target.y - previousPos.y, previousPos.x-target.x)-atan2(target.y - position.y, position.x-target.x)
     print("ANGLE: \(angle)")
     
     colorView.transform = CGAffineTransform(rotationAngle: angle)
     
     
     
     }
     }*/
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        tapped=false
        let touch: UITouch = touches.first!
        
        var currentTouch = touch.location(in: self.view)
        var previousTouch = touch.previousLocation(in: self.view)
        
        currentTouch.x = currentTouch.x - colorView.center.x
        currentTouch.y = colorView.center.y - currentTouch.y
        
        previousTouch.x = previousTouch.x - colorView.center.x
        previousTouch.y = colorView.center.y - previousTouch.y
        
        let angleDifference = atan2(previousTouch.y, previousTouch.x) - atan2(currentTouch.y, currentTouch.x)
        
        
        angle = atan2(self.view.transform.a, self.view.transform.b) + atan2(self.colorView.transform.a, self.colorView.transform.b);
        //print("angle: \(angle)")
        
        
        UIView.animate(withDuration: 0.05, animations: { () -> Void in
            self.colorView.transform = self.colorView.transform.rotated(by: angleDifference)
        })
        
        
        
        /*if let touch = touches.first {
         let position = touch.location(in: self.view)
         //print("POSITION: \(position)")
         let target = colorView.center
         //print("TARGET: \(target)")
         angle = atan2(target.y - position.y, target.x - position.x)
         print("ANGLE: \(angle)")
         //angle = atan2(self.view.transform.a, self.view.transform.b) + atan2(self.colorView.transform.a, self.colorView.transform.b);
         }*/
        
        //print("anchorpoint \(self.colorView.transform.b)")
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //let touch = touches.first
        //let position = touch?.location(in: self.colorView)
        //print("POS: \(pos)")
        
        /*if let touch = touches.first {
         let position = touch.location(in: self.view)
         print("POSITION: \(position)")
         let target = colorView.center
         print("TARGET: \(target)")
         angle = atan2(target.y - 5, target.x - 175)
         print("ANGLE: \(angle)")
         
         }*/
        
        //var psoition: CGPoint!
        //psoition = CGPoint(x: 66.8889074051365, y: 93.7094116796888)
        let color = getPixelColorAtPoint(point: colorPick.center)
        //print("Color:\(color)")
        //view.backgroundColor = color
        
        
        let fraction = angle.remainder(dividingBy: 0.7854)
        //print(" Fraction: \(fraction)")
        
        if tapped == true
        {
            //let touch: UITouch = touches.first!
            
            if let touch = touches.first {
                let position = touch.location(in: self.view)
                let distance = (pow(colorView.center.x - position.x,2) + pow(colorView.center.y - position.y,2))
                if distance < pow(80/2,2){
                    //createPaletteView
                    
                    //let colorListViewController = self.storyboard!.instantiateViewController(withIdentifier: "ColorListViewController") as! ColorListViewController
                    self.performSegue(withIdentifier: "ColorListViewController", sender: self)
                    //self.present(colorListViewController, animated: true, completion: nil)
                    ButtonTapped=true
                }
                else{
                    colorSelectionWithTap()
                }
            }
        }
        else{
            colorSelectionWithMotion()
            
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.colorView.transform = CGAffineTransform(rotationAngle: CGFloat(self.animAngle))
            //self.colorView.transform = self.colorView.transform.rotated(by: self.angle)
        })
        //colorPick = ColorPick()
        if ButtonTapped==false{
            colorPick.counterColor = selectedColor
            colorPick.setNeedsDisplay()
        }
        
        //view.backgroundColor = selectedColor
        
        //colorView.transform = CGAffineTransform(rotationAngle: fraction)
        imageView.newcolor = selectedColor
    }
    
    func colorSelectionWithMotion(){
        if (0 < angle && angle < 0.78)  {
            
            let newAngle = 0 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 0.78 {
                selectedColor = colorView.colorArray[5]
                //selectedColor = UIColor.brown
                animAngle=2.34
                print("asdf")
                
            } else {
                selectedColor = colorView.colorArray[4]
                //selectedColor = UIColor.blue
                animAngle=3.14
            }
            
        }
        else if (0.78 < angle && angle < 1.57)  {
            let newAngle = 0.78 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 1.57 {
                selectedColor = colorView.colorArray[6]
                //selectedColor = UIColor.magenta
                animAngle=1.57
                print("asdf")
            } else {
                selectedColor = colorView.colorArray[5]
                //selectedColor = UIColor.brown
                animAngle=2.34
            }
        }
        else if (1.57 < angle && angle < 2.34)  {
            let newAngle = 1.57 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 2.34 {
                selectedColor = colorView.colorArray[7]
                //selectedColor = UIColor.purple
                animAngle=0.78
                print("asdf")
            } else {
                selectedColor = colorView.colorArray[6]
                //selectedColor = UIColor.magenta
                animAngle=1.57
            }
        }
        else if (2.34 < angle && angle < 3.14)  {
            let newAngle = 2.34 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 3.14 {
                selectedColor = colorView.colorArray[0]
                //selectedColor = UIColor.red
                animAngle = -0.01
                print("asdf")
            } else {
                selectedColor = colorView.colorArray[7]
                //selectedColor = UIColor.purple
                animAngle=0.78
            }
        }
        else if (3.14 < angle && angle < 3.92)  {
            let newAngle = 3.14 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 3.92 {
                selectedColor = colorView.colorArray[1]
                //selectedColor = UIColor.green
                animAngle = -0.78
                print("asdf")
            } else {
                selectedColor = colorView.colorArray[0]
                //selectedColor = UIColor.red
                animAngle = -0.01
            }
        }
        else if (3.92 < angle && angle < 4.70)  {
            let newAngle = 3.92 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 4.70 {
                selectedColor = colorView.colorArray[2]
                //selectedColor = UIColor.orange
                animAngle = -1.58
                print("asdf")
            } else {
                selectedColor = colorView.colorArray[1]
                //selectedColor = UIColor.green
                animAngle = -0.78
            }
        }
        else if (-1.58 < angle && angle < -0.78)  {
            let newAngle = -1.58 + 0.4
            
            if CGFloat(newAngle) < angle && angle < -0.78 {
                selectedColor = colorView.colorArray[3]
                //selectedColor = UIColor.yellow
                animAngle = -2.35
                print("asdf")
            } else {
                selectedColor = colorView.colorArray[2]
                //selectedColor = UIColor.orange
                animAngle = -1.58
            }
        }
        else if (-0.78 < angle && angle < 0)  {
            let newAngle = -0.78 + 0.4
            
            if CGFloat(newAngle) < angle && angle < 0 {
                selectedColor = colorView.colorArray[4]
                //selectedColor = UIColor.blue
                animAngle = 3.14
                print("asdf")
            } else {
                selectedColor = colorView.colorArray[3]
                //selectedColor = UIColor.yellow
                animAngle = -2.35
            }
        }
        
    }
    
    func colorSelectionWithTap(){
        if selectedColor == colorView.colorArray[0] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
            }
        }
            
        else if selectedColor == colorView.colorArray[1] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
            }
        }
            
        else if selectedColor == colorView.colorArray[2] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
            }
        }
            
        else if selectedColor == colorView.colorArray[3] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
            }
        }
            
        else if selectedColor == colorView.colorArray[4] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
            }
        }
            
        else if selectedColor == colorView.colorArray[5] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
            }
        }
            
        else if selectedColor == colorView.colorArray[6] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
            }
        }
            
        else if selectedColor == colorView.colorArray[7] {
            if (1.2 < angle && angle < 1.9)  {
                
                animAngle = 0.78
                selectedColor = colorView.colorArray[7]
                
            } else if (1.9 < angle && angle < 2.6) {
                
                animAngle = -0.01
                selectedColor = colorView.colorArray[0]
                
                
            }else if (2.6 < angle && angle < 3.1416 || -3.1416 < angle && angle < -2.7) {
                
                animAngle = -0.78
                selectedColor = colorView.colorArray[1]
                
            }
            else if (-2.7 < angle && angle < -1.9) {
                
                animAngle = -1.58
                selectedColor = colorView.colorArray[2]
                
            } else if (-1.9 < angle && angle < -1.2) {
                
                animAngle = -2.35
                selectedColor = colorView.colorArray[3]
                
            } else if (-1.2 < angle && angle < -0.4) {
                
                animAngle = 3.14
                selectedColor = colorView.colorArray[4]
                
            }else if (-0.4 < angle && angle < 0.4) {
                
                animAngle = 2.34
                selectedColor = colorView.colorArray[5]
                
            }
            else if (0.4 < angle && angle < 1.2) {
                
                animAngle = 1.57
                selectedColor = colorView.colorArray[6]
            }
        }
    }
    func colorPaletteSelection(a: String, b:String, c:String, d:String, e:String, f:String, g:String, h:String){
        colorView.colorArray.removeAll()
        colorView.colorArray.append(UIColor.init(hexString: a)!)
        colorView.colorArray.append(UIColor.init(hexString: b)!)
        colorView.colorArray.append(UIColor.init(hexString: c)!)
        colorView.colorArray.append(UIColor.init(hexString: d)!)
        colorView.colorArray.append(UIColor.init(hexString: e)!)
        colorView.colorArray.append(UIColor.init(hexString: f)!)
        colorView.colorArray.append(UIColor.init(hexString: g)!)
        colorView.colorArray.append(UIColor.init(hexString: h)!)
        
        colorPick.counterColor = colorView.colorArray[0]
    }
    //returns the color data of the pixel at the currently selected point
    func getPixelColorAtPoint(point:CGPoint) -> UIColor {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        colorView.layer.render(in: context!)
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0, green: CGFloat(pixel[1])/255.0, blue: CGFloat(pixel[2])/255.0, alpha: CGFloat(pixel[3])/255.0)
        
        pixel.deallocate(capacity: 4)
        return color
    }
}
