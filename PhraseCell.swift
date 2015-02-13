import UIKit

class PhraseCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource, PlayAudioDelegate {

    @IBOutlet weak var fromPhrase: UIButton!
    @IBOutlet weak var toPhrase: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var selectedHeader: UIImageView!
    @IBOutlet weak var moreInfo: UIButton!
    @IBOutlet weak var subphraseTable: UITableView!
    
    var slideOutState: SlideOutState = .closed
    var phraseObject:Translations?
    var delegate: PlayAudioDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var phraseNib : UINib = UINib(nibName: "SubphraseCell", bundle: nil)
        subphraseTable.registerNib(phraseNib, forCellReuseIdentifier: "cell")
        //When I comment out the delegate and dataSource the error no longer occurs
        subphraseTable.delegate = self
        subphraseTable.dataSource = self
        cardView.layer.cornerRadius = 5.0
        cardView.layer.shadowColor = UIColor.grayColor().CGColor
        cardView.layer.shadowOpacity = 0.16
        cardView.layer.shadowOffset = CGSizeMake(0,5)
        backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    }
    
    func setAudioDelegate(delegate: PlayAudioDelegate){
        self.delegate = delegate
    }
    
    func setPhraseObject(phraseObject:Translations){
        self.phraseObject = phraseObject
        fromPhrase.setTitle("Phrase", forState: .Normal)
        toPhrase.setTitle("Phrase", forState: .Normal)
        subphraseTable.frame.size = CGSizeMake(subphraseTable.frame.width,CGFloat(48 * phraseObject.subphrases.count))
        cardView.frame.size = CGSizeMake(subphraseTable.frame.width,CGFloat(160 + subphraseTable.frame.height))
        cardArrow.frame.origin = CGPoint(x: cardArrow.frame.origin.x, y: 130 + subphraseTable.frame.height)
        subphraseTable.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = subphraseTable.dequeueReusableCellWithIdentifier("cell") as SubphraseCell
        cell.setSubphraseObject(phraseObject!.subphrases.allObjects[indexPath.row] as Translations)
        cell.setAudioDelegate(self)
        return cell
    }
    
    @IBAction func fromPhraseTapped(sender: AnyObject) {
        let audioArray = phraseObject!.fromAudios.allObjects as Array
        if let file = audioArray.first as? Files{
            if let localUrl = file.localUrl{
                delegate?.playAudio(localUrl)
            }
        }
    }
    
    @IBAction func toPhraseTapped(sender: AnyObject) {
        let audioArray = phraseObject!.toAudios.allObjects as Array
        if let file = audioArray.first as? Files{
            if let localUrl = file.localUrl{
                delegate?.playAudio(localUrl)
            }
        }
    }
    
    func playAudio(localUrl: String) {
        delegate?.playAudio(localUrl)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(phraseObject != nil){
            return phraseObject!.subphrases.count
        }
        return 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
