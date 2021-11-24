//
//  ActivityDetailsComposer.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import Foundation
import LazyFolksEngine
import LazyFolksiOS
import UIKit

public final class ActivityDetailsComposer {
    public static func compose(
        windowBounds: CGRect,
        viewData: ActivityDetailsViewData
    ) -> ActivityDetailsViewController {
        ActivityDetailsViewController(detailsView: makeView(windowBounds: windowBounds, viewData: viewData))
    }
    
    private static func makeView(
        windowBounds: CGRect,
        viewData: ActivityDetailsViewData
    ) -> ActivityDetailsView {
        ActivityDetailsView(
            frame: windowBounds,
            viewData: viewData,
            typeFieldTitle: ActivityDetailsPresenter.typeFieldTitle,
            participantsFieldTitle: ActivityDetailsPresenter.participantsFieldTitle,
            priceFieldTitle: ActivityDetailsPresenter.priceFieldTitle
        )
    }
}
