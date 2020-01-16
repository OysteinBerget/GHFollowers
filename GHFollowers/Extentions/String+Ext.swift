
import Foundation

extension String {
    //    According to the form validation messages on Join Github page,
    //
    //    Github username may only contain alphanumeric characters or hyphens.
    //    Github username cannot have multiple consecutive hyphens.
    //    Github username cannot begin or end with a hyphen.
    //    Maximum is 39 characters.
    //
    //   GitHub valid username regex: "^[a-zA-Z\d](?:[a-zA-Z\d]|-(?=[a-zA-Z\d])){0,38}$"
    var isValidGitHubUsername: Bool {
        let githubLoginFormat         = "^[a-zA-Z\\d](?:[a-zA-Z\\d]|-(?=[a-zA-Z\\d])){0,38}$"
        let githubLoginPredicate      = NSPredicate(format: "SELF MATCHES %@", githubLoginFormat)
        return githubLoginPredicate.evaluate(with: self)
    }

    var isValidEmail: Bool {
        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }


    var isValidPassword: Bool {
        //Regex restricts to 8 character minimum, 1 capital letter, 1 lowercase letter, 1 number
        //If you have different requirements a google search for "password requirement regex" will help
        let passwordFormat      = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate   = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }


    var isValidPhoneNumber: Bool {
        let phoneNumberFormat = "^\\d{3}-\\d{3}-\\d{4}$"
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberFormat)
        return numberPredicate.evaluate(with: self)
    }
    


    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
