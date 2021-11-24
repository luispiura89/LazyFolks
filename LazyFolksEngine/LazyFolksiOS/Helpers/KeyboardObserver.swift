//
//  KeyboardObserver.swift
//  LazyFolksiOS
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import UIKit

final class KeyboardObserver {
    
    private var onShow: ((CGRect) -> Void)?
    private var onHide: (() -> Void)?
    
    init(onShow: ((CGRect) -> Void)? = nil, onHide: (() -> Void)? = nil) {
        self.onShow = onShow
        self.onHide = onHide
        startObserving()
    }
    
    func stopObserving() {
        NotificationCenter.default.removeObserver(self)
        onHide = nil
        onShow = nil
    }
    
    private func startObserving() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func handleKeyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        onShow?(keyboardFrame)
    }
    
    @objc private func handleKeyboardWillHide(notification: Notification) {
        onHide?()
    }
}

protocol KeyboardObservable: AnyObject {
    var keyboardObserver: KeyboardObserver? { get set }
    func startKeyboardObserving(onShow: @escaping (CGRect) -> Void,
                                onHide: @escaping () -> Void)
    func stopKeyboardObserving()
}

extension KeyboardObservable {
    
    func startKeyboardObserving(onShow: @escaping (_ keyboardFrame: CGRect) -> Void,
                                onHide: @escaping () -> Void) {
        keyboardObserver = KeyboardObserver(onShow: onShow, onHide: onHide)
    }
    
    func stopKeyboardObserving() {
        keyboardObserver?.stopObserving()
        keyboardObserver = nil
    }
}
