//
//  Score1View.swift
//  SampleApp
//
//  Created by 김진님/AI Assistant개발 Cell on 2020/05/17.
//  Copyright © 2020 SK Telecom Co., Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

import NuguUIKit

final class Score1View: DisplayView {
    
    @IBOutlet private weak var statusLabel: UILabel!
    
    @IBOutlet private weak var leftScoreImageView: UIImageView!
    @IBOutlet private weak var leftScoreHeaderLabel: UILabel!
    @IBOutlet private weak var leftScoreBodyLabel: UILabel!
    @IBOutlet private weak var leftScoreFooterLabel: UILabel!
    
    @IBOutlet private weak var rightScoreImageView: UIImageView!
    @IBOutlet private weak var rightScoreHeaderLabel: UILabel!
    @IBOutlet private weak var rightScoreBodyLabel: UILabel!
    @IBOutlet private weak var rightScoreFooterLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    override var displayPayload: Data? {
        didSet {
            guard let payloadData = displayPayload,
                let displayItem = try? JSONDecoder().decode(Score1Template.self, from: payloadData) else { return }
            
            // Set backgroundColor
            backgroundColor = UIColor.backgroundColor(rgbHexString: displayItem.background?.color)
                        
            // Set title
            titleView.setData(titleData: displayItem.title)
            titleView.onCloseButtonClick = { [weak self] in
                self?.onCloseButtonClick?()
            }
            
            // Set sub title
            if let subIconUrl = displayItem.title.subicon?.sources.first?.url {
                subIconImageView.loadImage(from: subIconUrl)
                subIconImageView.isHidden = false
            } else {
                subIconImageView.isHidden = true
            }
            subTitleLabel.setDisplayText(displayText: displayItem.title.subtext)
            subTitleContainerView.isHidden = (displayItem.title.subtext == nil)
            
            // Set status label
            if let schedule = displayItem.content.schedule {
                statusLabel.text = schedule.text?.appending(" ")
            }
            statusLabel.text?.append(displayItem.content.status.text ?? "")
                                    
            // Set match views
            leftScoreImageView.loadImage(from: displayItem.content.match[0].image.sources.first?.url)
            leftScoreHeaderLabel.setDisplayText(displayText: displayItem.content.match[0].header)
            leftScoreBodyLabel.setDisplayText(displayText: displayItem.content.match[0].body)
            leftScoreFooterLabel.setDisplayText(displayText: displayItem.content.match[0].footer)
            
            rightScoreImageView.loadImage(from: displayItem.content.match[1].image.sources.first?.url)
            rightScoreHeaderLabel.setDisplayText(displayText: displayItem.content.match[1].header)
            rightScoreBodyLabel.setDisplayText(displayText: displayItem.content.match[1].body)
            rightScoreFooterLabel.setDisplayText(displayText: displayItem.content.match[1].footer)
            
            // Set score label
            scoreLabel.text = (displayItem.content.match[0].score.text ?? "-") + " : " + (displayItem.content.match[1].score.text ?? "-")
            
            // Set content button
            if let buttonItem = displayItem.title.button {
                contentButtonContainerView.isHidden = false
                contentButton.setTitle(buttonItem.text, for: .normal)
                switch buttonItem.eventType {
                case .elementSelected:
                    contentButtonEventType = .elementSelected(token: buttonItem.token, postback: buttonItem.postback)
                case .textInput:
                    contentButtonEventType = .textInput(textInput: buttonItem.textInput)
                default:
                    break
                }
            } else {
                contentButtonContainerView.isHidden = true
            }
            
            // Set chips data (grammarGuide)
            idleBar.chipsData = displayItem.grammarGuide?.compactMap({ (grammarGuide) -> NuguChipsButton.NuguChipsButtonType in
                return .normal(text: grammarGuide)
            }) ?? []
        }
    }
    
    override func loadFromXib() {
        // swiftlint:disable force_cast
        let view = Bundle.main.loadNibNamed("Score1View", owner: self)?.first as! UIView
        // swiftlint:enable force_cast
        view.frame = bounds
        addSubview(view)
        
        statusLabel.layer.cornerRadius = statusLabel.bounds.size.height/2
        statusLabel.layer.borderColor = UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0).cgColor
        statusLabel.layer.borderWidth = 0.5
        
        leftScoreImageView.clipsToBounds = true
        leftScoreImageView.layer.cornerRadius = 4.0
        
        rightScoreImageView.clipsToBounds = true
        rightScoreImageView.layer.cornerRadius = 4.0
    }
}
