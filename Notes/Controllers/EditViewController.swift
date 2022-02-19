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
    
    var selectedNote: Note? = nil
    var selectedIndex: Int? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(selectedNote != nil){
            notesTitle.text = selectedNote?.noteTitle
            notesDescription.text = selectedNote?.noteText
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if(selectedNote == nil){
            let newNote = Note(context: context)
            newNote.noteTitle = notesTitle.text!
            newNote.noteText = notesDescription.text!
            newNote.noteId = UUID()
            newNote.noteTimeStamp = Date()
            
            notesArray.append(newNote)

            saveNote()
            navigationController?.popViewController(animated: true)
        }
        else{
            editNote()
            navigationController?.popViewController(animated: true)
        }


    }
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let results = try context.fetch(request)
            for note in results {
                if(note == selectedNote){
                    context.delete(notesArray[selectedIndex!])
                    notesArray.remove(at: selectedIndex!)
                    try context.save()
                }
            }
        } catch {
            print("Error deleting context, \(error)")
        }

        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Saving & Loading Data
    
    func saveNote(){
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
    }
    func editNote(){
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do{
            let results = try context.fetch(request)
            for note in results {
                if(note == selectedNote){
                    note.noteTitle = notesTitle.text!
                    note.noteText = notesDescription.text!
                    try context.save()
                }
            }
        } catch{
            print("Error editing context, \(error)")
        }
    }
    

}

