//
//  LoginViewController.swift
//  
//
//  Created by adyao20 on 7/25/17.
//
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase


typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // 1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        
        print("login button tapped")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        // 1
        guard let user = user
            else { return }
        
        // 2
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        // 3
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // retrieve user data from snapshot
            // 1
            userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
                if let user = User(snapshot: snapshot) {
                    print("Welcome back, \(user.username).")
                } else {
                    self.performSegue(withIdentifier: "toCreateUsername", sender: self)
                }
            })
        
        print("handle user signup / login")
    }
        )}
}
