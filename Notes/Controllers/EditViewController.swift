//
//  ViewController.swift
//  Notes
//
//  Created by Hayley Robinson on 2/16/22.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var notesTitle: UITextField!
    @IBOutlet weak var notesDescription: UITextView!
    
    var notesArray = [Note?]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        notesArray.append(newNote)
        saveItems()
        
    }
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Saving & Loading Data
    
    func saveItems(){
        do {
            try context.save( )
        } catch {
            print("Error saving context \(error)")
        }
    }
    

}

