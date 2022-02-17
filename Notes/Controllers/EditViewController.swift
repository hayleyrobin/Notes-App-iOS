//
//  ViewController.swift
//  Notes
//
//  Created by Hayley Robinson on 2/16/22.
//

import UIKit
import CoreData

protocol AddNoteDelegate {
    func appendNote(note: Note)
}
class EditViewController: UIViewController {

    @IBOutlet weak var notesTitle: UITextField!
    @IBOutlet weak var notesDescription: UITextView!
    
    var selectedNote = Note()
    var notesArray = [Note?]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate: AddNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func saveNote(_ sender: UIBarButtonItem)
    {
        let newNote = Note(context: context)
        newNote.noteTitle = notesTitle.text!
        newNote.noteText = notesDescription.text!
        newNote.noteId = UUID()
        newNote.noteTimeStamp = Date()
        
        delegate?.appendNote(note: newNote)
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
    }
    

    

}

