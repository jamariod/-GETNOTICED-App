//
//  EntrepreneurTableViewController.swift
//  EIPS-RSS
//
//  Created by Jamario Davis on 10/29/19.
//  Copyright © 2019 KAYCAM. All rights reserved.
//


import UIKit

class BlogPosta {
    var title = String()
    var link = String()
    var description = String()
    var date = String()
}

class EntrepreneurTableViewController: UITableViewController, XMLParserDelegate {

   var parser = XMLParser()
          var blogPosts: [BlogPosta] = []
          var eName = String()
          var postTitle = String()
          var postLink = String()
          var descriptionText = String()
          var postDate = String()
          
          override func viewDidLoad() {
              super.viewDidLoad()

              navigationController?.navigationBar.shadowImage = UIImage()
              tableView.estimatedRowHeight = 100
              tableView.rowHeight = UITableView.automaticDimension
              let url = URL(string: "https://www.entrepreneur.com/latest.rss")
              
              parser = XMLParser(contentsOf: url!)!
              parser.delegate = self
              parser.parse()
          }
          func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
              eName = elementName
              if elementName == "item" {
                  postTitle = String()
                  postLink = String()
                  descriptionText = String()
                  postDate = String()
              }
          }
          func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
              if elementName == "item" {
                  let blogPosta: BlogPosta = BlogPosta()
                  blogPosta.title = postTitle
                  blogPosta.link = postLink
                  blogPosta.description = descriptionText
                  blogPosta.date = postDate
                  blogPosts.append(blogPosta)
              }
          }
          func parser(_ parser: XMLParser, foundCharacters string: String) {
              let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
              if (!data.isEmpty) {
                  if eName == "title" {
                      postTitle += data
                  } else if eName == "link" {
                      postLink += data
                  } else if eName == "description" {
                      descriptionText += data
                  } else if eName == "pubDate" {
                      let dateFormatter = DateFormatter()
                      dateFormatter.dateFormat = "EEE, dd LLL yyyy HH:mm:ss zzz"
                      dateFormatter.timeZone = TimeZone(abbreviation: "PDT")
                      let formattedDate = dateFormatter.date(from: data)
                      if formattedDate != nil {
                          dateFormatter.dateStyle = .medium
                          dateFormatter.timeStyle = .none
                          postDate = dateFormatter.string(from: formattedDate!)
                      }
                  }
              }
          }
          func parserDidEndDocument(_ parser: XMLParser) {
              self.tableView.reloadData()
          }
          
          // MARK: - Table view data source
          override func numberOfSections(in tableView: UITableView) -> Int {
              return 1
          }
          override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return blogPosts.count
          }
          override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
              let currentBlogPost: BlogPosta = blogPosts[indexPath.row]
              cell.textLabel?.text = currentBlogPost.title
              cell.detailTextLabel?.text = currentBlogPost.description
              cell.textLabel?.numberOfLines = 0
              cell.detailTextLabel?.numberOfLines = 1
              let dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
              dateLabel.textColor = UIColor.black
              dateLabel.textAlignment = .right
              dateLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
              dateLabel.text = currentBlogPost.date
              dateLabel.textColor = UIColor.black
              cell.accessoryView = dateLabel
              return cell
          }
          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if (segue.identifier == "post") {
                  let webView: WebviewPosta = segue.destination as! WebviewPosta
                  webView.blogPostURL = URL(string:blogPosts[(tableView.indexPathForSelectedRow?.row)!].link)
              }
          }
      }


