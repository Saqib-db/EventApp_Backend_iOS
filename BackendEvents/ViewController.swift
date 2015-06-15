//
//  ViewController.swift
//  BackendEvents
//
//  Created by saqib on 1/3/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var counter=0
var cityTxt="islamabad"
var EventTypeTxt="music"
    
    @IBOutlet weak var City: UITextField!
    
    @IBOutlet weak var EventType: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func Clicker(sender: UIButton) {
        
        var message=" and awsome!"
        
        cityTxt=self.City.text
        EventTypeTxt=self.EventType.text
        println(cityTxt+" daba "+EventTypeTxt)
        
        
        var testcls=TestClass()
        
        
        
        let alertController = UIAlertController(title: "Hey AppCoda", message: "What do you want to do?", preferredStyle: .ActionSheet)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        counter=showMessage(message,Counter: counter)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func showMessage(AnotherMessage : String, Counter : Int) ->Int{
        println(String(Counter)+" : "+AnotherMessage)
        
        
        
        
        
        
        var imageSearcher = "//div[@class='event-item']/div[@class='event-thumb-wrap']/img"
        var Titleearcher = "//div[@class='event-item']/div[@class='event-body clearfix']/div[@class='left']/h3/a"
        var LocationSearcher = "//div[@class='event-item']/div[@class='event-body clearfix']/div[@class='left']/p/span"
        var TimeSearcher = "//div[@class='event-item']/div[@class='event-body clearfix']/div[@class='right']/span"
        
        
        
        var IMagesArray:[String]=Extract("http://allevents.in/"+cityTxt+"/"+EventTypeTxt, stringpath: imageSearcher)
        var TitleArray:[String]=Extract("http://allevents.in/"+cityTxt+"/"+EventTypeTxt, stringpath: Titleearcher)
        var LocationArray:[String]=Extract("http://allevents.in/"+cityTxt+"/"+EventTypeTxt, stringpath: LocationSearcher)
        var TimeArray:[String]=Extract("http://allevents.in/"+cityTxt+"/"+EventTypeTxt, stringpath: TimeSearcher)


        
        for var index = 0; index < TitleArray.count; ++index{
            
            var object = PFObject(className: "Events")
            
            object.setObject(TitleArray[index], forKey: "Title")
            object.setObject(IMagesArray[index], forKey: "Image")
            object.setObject(LocationArray[index], forKey: "Location")
            object.setObject(TimeArray[index], forKey: "Time")


           
            
            
            
            var LocaObj=PFGeoPoint.init(latitude: 0,longitude: 0)
            
            
            
            
            
            object.setObject(LocaObj, forKey: "Location_Coordinates")

            object.setObject(cityTxt, forKey: "Creator")
            object.setObject(EventTypeTxt, forKey: "Event_Type")

            object.save()

            
            println(TitleArray[index]+" done________")

        }

        
        //event-list listview
        
        
        
        
        
        
        
        return Counter+1
        
        
    }
    
    func Extract(url : String, stringpath : String ) ->Array<String>{
        var valuesToReturn:[String]=[]
        
        var tutorialsURL = NSURL(string: url)
        var htmlData: NSData = NSData(contentsOfURL: tutorialsURL!)!
        
        
        var tutorialsParser = TFHpple(HTMLData: htmlData)
        var tutorialsXPathString = stringpath
        var tutorialNodes = tutorialsParser.searchWithXPathQuery(tutorialsXPathString) as NSArray
        if(tutorialNodes.count == 0)
        {
            println("empty here")
        }
        else
        {
            for element in tutorialNodes{
                
                if(element.tagName=="img"){
                    var imageLink: String!=element.objectForKey("data-original")
                    
                    imageLink.substringWithRange(Range<String.Index>(start: advance(imageLink.startIndex, 11), end: advance(imageLink.endIndex, -1)))
                    valuesToReturn.append(imageLink)
                    // println(imageLink)
                    
                }
                else if(element.tagName=="a"){
                    valuesToReturn.append(element.content)
                    
                }
                else if(element.tagName=="span"){
                    valuesToReturn.append(element.content)
                    
                }
                else{
                    println(element.tagName)
                }
                
                
                
                
                
                
            }
            
            
            
        }
        
        
        return valuesToReturn
    }
    
    
    
    


}


class TestClass {
    var message="saqib the great"
   

    
    
    
}

