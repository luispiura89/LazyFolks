//
//  ActivityDetailsItemView.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 27/11/21.
//

import UIKit

public final class ActivityDetailsItemView: UIStackView {
    
    private var icon: String?
    private var info: String?
    private var title: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String?, info: String?, icon: String?) {
        self.init(frame: .zero)
        self.icon = icon
        self.info = info
        self.title = title
        axis = .horizontal
        spacing = 20
        translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        isLayoutMarginsRelativeArrangement = true
        alignment = .leading
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 5
        addArrangedSubview(iconImageView)
        addArrangedSubview(makeFieldContainer(title: titleLabel, info: infoLabel))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public private(set) lazy var infoLabel: UILabel = {
        makeViews().info
    }()
    
    private lazy var titleLabel: UILabel = {
        makeViews().title
    }()
    
    private lazy var iconImageView: UIImageView = {
        makeViews().icon
    }()
    
    private func makeViews() -> (title: UILabel, info: UILabel, icon: UIImageView) {
        makeFieldViews(fieldTitle: title, fieldValue: info, iconName: icon)
    }
    
    private func makeFieldContainer(title: UILabel, info: UILabel) -> UIStackView {
        UIStackView.makeStackView(
            subviews: [
                title,
                info
            ],
            margins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            spacing: 8
        )
    }
    
    private func makeFieldViews(
        fieldTitle: String?,
        fieldValue: String?,
        iconName: String?
    ) -> (title: UILabel, info: UILabel, icon: UIImageView) {
        let info = UILabel.makeLabel(
            text: fieldValue,
            numberOfLines: 0,
            textStyle: .subheadline,
            textColor: UIColor(named: "Orange1", in: Bundle(for: Self.self), compatibleWith: nil)
        )
        
        let title = UILabel.makeLabel(
            text: fieldTitle,
            numberOfLines: 0,
            textStyle: .headline,
            textColor: UIColor(named: "Orange1", in: Bundle(for: Self.self), compatibleWith: nil)
        )
        
        let image = UIImage(named: iconName ?? "", in: Bundle(for: Self.self), compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        imageView.contentMode = .scaleAspectFit
        return (title, info, imageView)
    }
    
}
