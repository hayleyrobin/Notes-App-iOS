//
//  NotesViewController.swift
//  Notes
//
//  Created by Hayley Robinson on 2/16/22.
//

import UIKit
import CoreData

var notesArray = [Note]()

class NotesViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNotes()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func addNotePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddNote", sender: self)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)

        cell.textLabel?.text = notesArray[indexPath.row].noteTitle

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditNote", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "EditNote"{
            let destinationVC = segue.destination as! EditViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedNote = notesArray[indexPath.row]
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    // MARK: - Saving & Loading Data
    
    func loadNotes(){
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do{
            notesArray = try context.fetch(request)
        }catch {
            print("Error loading context, \(error)")
        }
        tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

}
