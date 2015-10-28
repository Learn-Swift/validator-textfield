//
//  PhoneValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation
import libPhoneNumber_iOS

public class PhoneNumberRule: Rule {

    private let phoneUtil = NBPhoneNumberUtil()
	private let countryCode	: UITextField
	private var message		: String
	private var errorPointer: NSError?

	public init(confirmField: UITextField, message : String = "errrrr"){
		self.countryCode	= confirmField
		self.message		= message
	}

	public func validate(value: String) -> Bool {
		var isValid = false;
		do{
			let phoneNumber:NBPhoneNumber	= try phoneUtil.parse(value, defaultRegion: countryCode.text)
			isValid							= phoneUtil.isValidNumberForRegion(phoneNumber, regionCode: countryCode.text)
		}
		catch let error as NSError {
			print(error.localizedDescription)
			isValid = false
		}

		return isValid
	}

	public func errorMessage() -> String {
		return message
	}
}
