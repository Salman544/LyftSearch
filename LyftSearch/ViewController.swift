//
//  ViewController.swift
//  LyftSearch
//
//  Created by Muhammad Salman Zafar on 26/12/2018.
//  Copyright © 2018 Muhammad Salman Zafar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationPickerView: UIView!
    @IBOutlet weak var pickerCenterYConstaint: NSLayoutConstraint!
    @IBOutlet weak var roundDotView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchLbl: UILabel!
    @IBOutlet weak var dropoffLbl: UILabel!
    @IBOutlet weak var closedBtn: UIButton!
    @IBOutlet weak var searchFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var goingLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContentView: UIView!
    @IBOutlet weak var searchViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchImageView: UIImageView!

    private var searchViewTapped: Bool = false
    private var searchResults = [Prediction]()
    private var searchTimer: Timer? = nil
    private var locationView: SelectLocationView!
    private var hideSearchView: Bool = false
    private var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchImageView.tintColor = #colorLiteral(red: 0.9176470588, green: 0.0431372549, blue: 0.5490196078, alpha: 1)
        searchImageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchViewDidTapped))
        tapGesture.delegate = self
        searchContentView.addGestureRecognizer(tapGesture)
        searchTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        
        addLocationView()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return searchViewTapped
    }
    
    func addLocationView() {
        locationView = SelectLocationView(contentView: view)
        locationView.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationBackViewTapped)))
        locationView.selectLocationBtn.addTarget(self, action: #selector(selectLocationBtnTapped), for: .touchUpInside)
        
        locationView.mainView.isHidden = true
    }
    
    @objc func searchViewDidTapped() {
        searchViewTapped.toggle()
        closedBtn.isEnabled = searchViewTapped
        searchTextField.isEnabled = searchViewTapped
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1) {
            
            self.searchViewHeightConstraint.constant = self.searchViewTapped ? self.view.frame.height + 10 : 147
            self.searchViewLeadingConstraint.constant = self.searchViewTapped ? 0 : 8
            self.searchViewTrailingConstraint.constant = self.searchViewTapped ? 0 : 8
            self.searchFieldTopConstraint.constant = self.searchViewTapped ? -10 : 8
            self.searchContentView.layer.cornerRadius = self.searchViewTapped ? 0 : 10
            self.goingLbl.alpha = self.searchViewTapped ? 0 : 1
            //self.searchLbl.alpha = self.goingLbl.alpha
            self.nameLbl.alpha = self.goingLbl.alpha
            self.closedBtn.alpha = self.searchViewTapped ? 1 : 0
            self.dropoffLbl.alpha = self.closedBtn.alpha
            self.searchTextField.text = ""
            self.setNeedsStatusBarAppearanceUpdate()
            self.view.layoutIfNeeded()
            
        }
        
        animator.addCompletion { (_) in
            self.searchView.isHidden = self.hideSearchView
            if self.searchViewTapped {
                self.searchTextField.becomeFirstResponder()
            }
            
            if !self.searchResults.isEmpty {
                self.searchResults = []
                self.tableView.reloadData()
            }
            
        }
        
        animator.startAnimation()
    }
    
    @IBAction func closedBtnTapped(_ sender: Any) {
        searchViewDidTapped()
    }
    
    @objc func locationBackViewTapped() {
        
        searchViewDidTapped()
        locationView.mainView.isHidden = true
        hideSearchView.toggle()
        locationPickerView.isHidden = true
        roundDotView.isHidden = true
    }
    
    @objc func selectLocationBtnTapped() {
        
        let alert = UIAlertController(title: "Yeah !!!", message: locationView.locationLabel.text ?? "None", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alert, animated: true)
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath)
        let pred = searchResults[indexPath.item]
        
        cell.textLabel?.text = pred.description ?? "None"
        cell.detailTextLabel?.text = pred.structuredFormatting?.secondaryText ?? "None"
        cell.imageView?.image = #imageLiteral(resourceName: "ic_search")
        cell.imageView?.tintColor = #colorLiteral(red: 0.9176470588, green: 0.0431372549, blue: 0.5490196078, alpha: 1)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let placeId = searchResults[indexPath.item].placeId else { return }
        let address = searchResults[indexPath.item].description ?? "None"
        let prams = ["key": ApiRequest.googleMapApiKey, "placeid": placeId]
        guard let url = ApiRequest.getUrl(path: ApiRequest.placedetail, paramaters: prams) else { return }
        
        NetworkRequest.fetchJson(with: url) { (result: ParsePlaceId) in
            guard let latlng = result.result.geometry?.location else { return }
            DispatchQueue.main.async {
                
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latlng.lat ?? 0, longitude: latlng.lng ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                self.mapView.setRegion(region, animated: true)
                self.hideSearchView.toggle()
                self.searchViewDidTapped()
                self.locationView.mainView.isHidden = false
                self.locationView.locationLabel.text = address
                self.locationPickerView.isHidden = false
                self.roundDotView.isHidden = false
                self.view.endEditing(true)
            }
            
        }
        
    }
    
}


extension ViewController {
    
    @objc func textFieldChanged(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        if text.isEmpty { return }
        
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        let prams = ["key": ApiRequest.googleMapApiKey, "input": text]
        
        guard let url = ApiRequest.getUrl(path: ApiRequest.autocomplete, paramaters: prams) else { return }
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            print("i am called")
            
            NetworkRequest.fetchJson(with: url, completion: { (rsl: GoogleAutoComplete) in
                guard let predictions = rsl.predictions else { return }
                self.searchResults = predictions
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        })
    }
    
}

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if self.searchViewTapped {
            return touch.view == searchContentView
        } else {
            return touch.view == searchView
        }
        
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if locationPickerView.isHidden { return }
        
        UIView.animate(withDuration: 0.2) {
            self.pickerCenterYConstaint.constant = -35
            self.view.layoutIfNeeded()
        }
        
        let latlng = "\(mapView.centerCoordinate.latitude),\(mapView.centerCoordinate.longitude)"
        let prams = ["key": ApiRequest.googleMapApiKey, "latlng": latlng]
        
        guard let url = ApiRequest.getUrl(path: ApiRequest.geocode, paramaters: prams) else { return }
        
        NetworkRequest.fetchJson(with: url) { (geocode: GoogleGeocode) in
            
            guard let address = geocode.results?.first?.formattedAddress else { return }
            DispatchQueue.main.async {
                self.locationView.locationLabel.text = address
                self.locationView.locationLabel.textColor = .black
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if locationPickerView.isHidden { return }
        
        UIView.animate(withDuration: 0.2) {
            self.pickerCenterYConstaint.constant = -45
            self.locationView.locationLabel.textColor = .lightGray
            self.view.layoutIfNeeded()
        }
    }
}
