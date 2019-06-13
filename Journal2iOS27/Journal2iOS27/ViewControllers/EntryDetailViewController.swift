//
//  EntryDetailViewController.swift
//  Journal2iOS27
//
//  Created by Austin West on 6/13/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet {
           if isViewLoaded { updateViews() }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    @IBAction func deleteTextButtonTapped(_ sender: Any) {
       titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, let text = bodyTextView.text else { return }
        
        if let entry = self.entry {
            EntryController.shared.update(entry: entry, with: title, text: text)
        } else {
            EntryController.shared.addEntryWith(title: title, text: text)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
