//
//  CustomTextField.swift
//  Expenser
//
//  Created by Dushyant Singh on 9/5/22.
//

import RxCocoa
import RxSwift
import RxGesture
import RxOptional
import UIKit

enum FontSize: CGFloat {
    case small = 14.0
    case medium = 16.0
    case large = 18.0
    case vLarge = 20.0
}

class CustomTextField: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var underlineView: UIView!

    private let disposeBag = DisposeBag()
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var keyboardType: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
    }

    var titleFontSize: FontSize {
        get { _titleFontSize }
        set { _titleFontSize = newValue
            self.titleLabel.font = Theme.Font.thinFont(with: newValue.rawValue)
        }
    }

    var textFontSize: FontSize {
        get { _textFontSize }
        set { _textFontSize = newValue
            self.textField.font = Theme.Font.regularFont(with: newValue.rawValue)
        }
    }

    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    var rx: Reactive<UITextField> {
        return textField.rx
    }

    private var _titleFontSize: FontSize = .small
    private var _textFontSize: FontSize = .medium
    private var _inputOptions: [String] = []
    private var pickerView: UIPickerView?

    var inputOptions: [String] {
        get { _inputOptions }
        set {
            if !newValue.isEmpty {
                _inputOptions = newValue
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupHighlighting()
    }

    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
}

extension CustomTextField {
    func sendActions(for controlEvents: UIControl.Event) {
        self.textField.sendActions(for: controlEvents)
    }

    func resetTextFieldParam() {
        self.textField.isSecureTextEntry = false
        self.textField.rightView = nil
        self.textField.textAlignment = .natural
        self.textField.keyboardType = .default
        self.textField.returnKeyType = .done
        self.textField.autocapitalizationType = .words
    }
}
private extension CustomTextField {

    func initSubviews() {
        contentView = self.viewFromNib(type: CustomTextField.self)
        addSubview(contentView)
    }

    func setupUI() {
        self.titleLabel.font = Theme.Font.thinFont(with: _titleFontSize.rawValue)
        self.textField.font = Theme.Font.regularFont(with: _textFontSize.rawValue)

        self.titleLabel.rx
            .tapGesture()
            .when(.ended)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.textField.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
    }

    func setupHighlighting() {
        self.textField.rx
            .controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self
                else { return }
                if self._inputOptions.isNotEmpty {
                    let text = self.textField.text ?? ""
                    if text.isEmpty {
                        self.textField.text = self._inputOptions.first
                    } else if let row = self._inputOptions.firstIndex(of: text) {
                        self.pickerView?.selectRow(row,
                                                   inComponent: 0,
                                                   animated: true)
                    }
                }
                self.underlineView.backgroundColor = Theme.Color.primaryColor
            })
            .disposed(by: disposeBag)

        self.textField.rx
            .controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] _ in
                self?.underlineView.backgroundColor = Theme.Color.textFieldBorderColor
            })
            .disposed(by: disposeBag)
    }
}

extension UIView {
    func viewFromNib<T>(type: T.Type) -> UIView {
        let nibName = String(describing: T.self)
        guard let classType = type as? AnyClass else {
            fatalError("Class unknown: \(nibName)")
        }

        let nib = UINib(nibName: nibName, bundle: Bundle(for: classType))
        let nibViews = nib.instantiate(withOwner: self, options: nil)

        guard let nibView = nibViews.first as? UIView else {
            fatalError("Unable to create view from nib \(nibName)")
        }

        nibView.frame = self.bounds
        nibView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                    UIView.AutoresizingMask.flexibleHeight]
        return nibView
    }
}
