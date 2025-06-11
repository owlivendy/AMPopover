//
//  ViewController.swift
//  Example
//
//  Created by shen xiaofei on 2025/6/10.
//

import UIKit
import AMPopover

class ViewController: UIViewController {
    
    private lazy var centerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("中心菜单", for: .normal)
        button.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var topLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("自定义视图", for: .normal)
        button.addTarget(self, action: #selector(topLeftButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var topRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("右上菜单", for: .normal)
        button.addTarget(self, action: #selector(topRightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("左下菜单", for: .normal)
        button.addTarget(self, action: #selector(bottomLeftButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("右下菜单", for: .normal)
        button.addTarget(self, action: #selector(bottomRightButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // 添加所有按钮
        [centerButton, topLeftButton, topRightButton, bottomLeftButton, bottomRightButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 设置按钮大小
        let buttonSize = CGSize(width: 120, height: 44)
        
        // 设置约束
        NSLayoutConstraint.activate([
            // 中心按钮
            centerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            centerButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            // 左上按钮
            topLeftButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topLeftButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topLeftButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            topLeftButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            // 右上按钮
            topRightButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            topRightButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topRightButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            topRightButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            // 左下按钮
            bottomLeftButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bottomLeftButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomLeftButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            bottomLeftButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            // 右下按钮
            bottomRightButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bottomRightButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomRightButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            bottomRightButton.heightAnchor.constraint(equalToConstant: buttonSize.height)
        ])
    }
    
    private func showMenu(from button: UIButton) {
        // 创建菜单项
        let items = [
            AMPopoverMenuItem.item(with: "分享"),
            AMPopoverMenuItem.item(with: "编辑"),
            AMPopoverMenuItem.item(with: "删除"),
            AMPopoverMenuItem.item(with: "更多选项")
        ]
        
        // 创建菜单视图
        let menuView = AMPopoverMenuView(menuItems: items)
        
        // 自定义菜单样式
        menuView.menuWidth = 120
        menuView.rowHeight = 44
        menuView.maxHeight = 44 * 4
        
        // 设置选择回调
        menuView.didSelectBlock = { [weak self] item in
            guard let self = self else { return }
            
            // 处理选择事件
            switch item.title {
            case "分享":
                self.showAlert(message: "点击了分享")
            case "编辑":
                self.showAlert(message: "点击了编辑")
            case "删除":
                self.showAlert(message: "点击了删除")
            case "更多选项":
                self.showAlert(message: "点击了更多选项")
            default:
                break
            }
        }
        
        // 显示菜单
        menuView.show(with: button)
    }
    
    @objc private func centerButtonTapped() {
        showMenu(from: centerButton)
    }
    
    @objc private func topLeftButtonTapped() {
        // 创建自定义内容视图
        let contentView = UIView()
        contentView.backgroundColor = .systemGray6
        
        // 创建标题标签
        let titleLabel = UILabel()
        titleLabel.text = "Custom View"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .label
        
        // 创建描述标签
        let descLabel = UILabel()
        descLabel.text = "This is a custom content view example"
        descLabel.textAlignment = .center
        descLabel.font = .systemFont(ofSize: 14)
        descLabel.textColor = .secondaryLabel
        descLabel.numberOfLines = 0
        
        // 创建按钮
        let actionButton = UIButton(type: .system)
        actionButton.setTitle("Action", for: .normal)
        actionButton.backgroundColor = .systemBlue
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 8
        
        // 添加子视图
        [titleLabel, descLabel, actionButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 设置约束
        NSLayoutConstraint.activate([
            // 内容视图大小
            contentView.widthAnchor.constraint(equalToConstant: 200),
            
            // 标题标签
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // 描述标签
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // 按钮
            actionButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 16),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // 创建弹出框
        let popover = AMPopover(contentView: contentView)
        
        // 自定义样式
        popover.arrowHeight = 10
        popover.arrowWidth = 16
        popover.cornerRadius = 12
        popover.minMargin = 15
        popover.contentBackgroundColor = .systemGray6
        
        // 添加按钮点击事件
        actionButton.addAction(UIAction { [weak self] _ in
            self?.showAlert(message: "Custom view button tapped")
            popover.hide()
        }, for: .touchUpInside)
        
        // 显示弹出框
        popover.show(with: topLeftButton)
    }
    
    @objc private func topRightButtonTapped() {
        // 创建菜单项
        let items = [
            AMPopoverMenuItem.item(with: "分享"),
            AMPopoverMenuItem.item(with: "编辑"),
            AMPopoverMenuItem.item(with: "删除"),
            AMPopoverMenuItem.item(with: "更多选项")
        ]
        
        // 创建菜单视图
        let menuView = AMPopoverMenuView(menuItems: items)
        
        // 自定义菜单样式
        menuView.menuWidth = 120
        menuView.rowHeight = 44
        menuView.maxHeight = 44 * 4
        menuView.menuBackgroundColor = .systemGray6 // 设置菜单背景色
        
        // 设置选择回调
        menuView.didSelectBlock = { [weak self] item in
            guard let self = self else { return }
            
            // 处理选择事件
            switch item.title {
            case "分享":
                self.showAlert(message: "点击了分享")
            case "编辑":
                self.showAlert(message: "点击了编辑")
            case "删除":
                self.showAlert(message: "点击了删除")
            case "更多选项":
                self.showAlert(message: "点击了更多选项")
            default:
                break
            }
        }
        
        // 显示菜单
        menuView.show(with: topRightButton)
    }
    
    @objc private func bottomLeftButtonTapped() {
        showMenu(from: bottomLeftButton)
    }
    
    @objc private func bottomRightButtonTapped() {
        showMenu(from: bottomRightButton)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}

