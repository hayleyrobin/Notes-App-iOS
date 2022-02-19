//
//  ViewController.swift
//  Notes
//
//  Created by Hayley Robinson on 2/16/22.
//

import UIKit
import CoreData

protocol AddNoteDelegate: class {
    func appendNote(note: Note)
}
class EditViewController: UIViewController {

    @IBOutlet weak var notesTitle: UITextField!
    @IBOutlet weak var notesDescription: UITextView!
    
    var selectedNote = Note()
    var notesArray = [Note?]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    weak var delegate: AddNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func savePressed(_ sender: Any) {
        let newNote = Note(context: context)
        newNote.noteTitle = notesTitle.text!
        newNote.noteText = notesDescription.text!
        newNote.noteId = UUID()
        newNote.noteTimeStamp = Date()
        
        notesArray.append(newNote)
//        delegate?.appendNote(note: newNote)
        saveItems()
        navigationController?.popViewController(animated: true)

    }
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Saving & Loading Data
    
    func saveItems(){
        do {
            try context.save()
            print("yes")
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    

}

