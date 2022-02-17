//
//  NotesViewController.swift
//  Notes
//
//  Created by Hayley Robinson on 2/16/22.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController, AddNoteDelegate {
    func appendNote(note: Note) {
        notesArray.append(note)
        saveItems()
    }

    var notesArray = [Note]()
    
    var noteObject = EditViewController()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteObject.delegate = self
        
        loadItems()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    }
    @IBAction func addNotePressed(_ sender: UIBarButtonItem) {
        let destinationVC = EditViewController()
        self.present(destinationVC, animated: true, completion: nil)
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
        performSegue(withIdentifier: "AddNote", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditViewController
        
//        destinationVC.notesArray = notesArray
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedNote = notesArray[indexPath.row]
        }
    }

    // MARK: - Saving & Loading Data
    
    func saveItems(){
        do {
            try context.save( )
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(){
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
