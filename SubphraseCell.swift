//
//  SubphraseCell.swift
//  TALL Basics
//
//  Created by Michael Patterson on 2/10/15.
//  Copyright (c) 2015 MTC. All rights reserved.
//

import UIKit

class SubphraseCell: UITableViewCell {

    @IBOutlet weak var fromSubphrase: UIButton!
    @IBOutlet weak var toSubphrase: UIButton!
    var subphraseObject:Translations?
    var delegate:PlayAudioDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setSubphraseObject(object: Translations){
        self.subphraseObject = object
        toSubphrase.setTitle(object.translation, forState: .Normal)
        fromSubphrase.setTitle(object.word, forState: .Normal)
    }
    
    func setAudioDelegate(delegate: PlayAudioDelegate){
        self.delegate = delegate
    }
    
    @IBAction func fromSubphraseTapped(sender: AnyObject) {
        if(subphraseObject != nil){
            let audioArray = subphraseObject!.fromAudios.allObjects as Array
            if let file = audioArray.first as? Files{
                if let localUrl = file.localUrl{
                    delegate?.playAudio(localUrl)
                }
            }
        }
    }
    @IBAction func toSubphraseTapped(sender: AnyObject) {
        if(subphraseObject != nil){
            let audioArray = subphraseObject!.toAudios.allObjects as Array
            if let file = audioArray.first as? Files{
                if let localUrl = file.localUrl{
                    delegate?.playAudio(localUrl)
                }
            }
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
