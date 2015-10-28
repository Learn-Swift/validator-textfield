//
//  ViewController.swift
//  validation-textfield
//
//  Created by Duc Nguyen on 10/28/15.
//  Copyright © 2015 Duc Nguyen. All rights reserved.
//

import UIKit
import SwiftValidator
import libPhoneNumber_iOS

class mainViewController: UIViewController, ValidationDelegate, UITextFieldDelegate {

	@IBOutlet weak var txtName		: UITextField!
	@IBOutlet weak var txtCode		: UITextField!
	@IBOutlet weak var txtPhone		: UITextField!
	
	@IBOutlet weak var lblNameError	: UILabel!
	@IBOutlet weak var lblPhoneError: UILabel!

	let validator = Validator()
	let phoneUtil = NBPhoneNumberUtil();


	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"))

		validator.styleTransformers(
			success:{ (validationRule) -> Void in
				print("here")
				// clear error label
				validationRule.errorLabel?.hidden = true
				validationRule.errorLabel?.text = ""
				validationRule.textField.layer.borderColor = UIColor.greenColor().CGColor
				validationRule.textField.layer.borderWidth = 0.5

			}, error:{ (validationError) -> Void in
				print("error")
				validationError.errorLabel?.hidden = false
				validationError.errorLabel?.text = validationError.errorMessage
				validationError.textField.layer.borderColor = UIColor.redColor().CGColor
				validationError.textField.layer.borderWidth = 1.0
		})

		validator.registerField(txtPhone, errorLabel: lblPhoneError , rules: [RequiredRule(), PhoneNumberRule(confirmField: txtCode)])
		validator.registerField(txtName, errorLabel: lblNameError , rules: [RequiredRule(), FullNameRule()])

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()

	}

	@IBAction func Continue(sender: AnyObject) {
		validator.validate(self)
	}

	func validationSuccessful() {
		print("Validation Success!")
		let alert = UIAlertController(title: "Success", message: "You are validated!", preferredStyle: UIAlertControllerStyle.Alert)
		let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
		alert.addAction(defaultAction)
		self.presentViewController(alert, animated: true, completion: nil)

	}
	func validationFailed(errors:[UITextField:ValidationError]) {
		for (field, error) in validator.errors {
			field.layer.borderColor = UIColor.redColor().CGColor
			field.layer.borderWidth = 1.0
			error.errorLabel?.text = error.errorMessage // works if you added labels
			error.errorLabel?.hidden = false
		}
		
		print("Validation FAILED!")
	}
	func hideKeyboard(){
		self.view.endEditing(true)
	}

}

