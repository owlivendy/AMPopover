import UIKit

public class AMPopoverMenuView: UIView {
    
    // MARK: - Properties
    
    /// 菜单的宽度
    /// - 默认值: 100.0
    /// - 影响整个菜单的水平宽度
    public var menuWidth: CGFloat = 100
    
    /// 菜单项的行高
    /// - 默认值: 44.0
    /// - 影响每个菜单项的垂直高度
    public var rowHeight: CGFloat = 44
    
    /// 菜单的最大高度
    /// - 默认值: 44.0 * 5
    /// - 当内容超过此高度时会显示滚动条
    public var maxHeight: CGFloat = 44 * 5
    
    /// 菜单的背景颜色
    /// - 默认值: 深色模式为 .systemGray6，浅色模式为 .white
    /// - 同时影响菜单内容和箭头的颜色
    public var menuBackgroundColor: UIColor = AMPopoverColor.defaultBackground {
        didSet {
            tableView.backgroundColor = menuBackgroundColor
            if let popoverView = popoverView {
                popoverView.contentBackgroundColor = menuBackgroundColor
            }
        }
    }
    
    /// 菜单项被选中时的回调
    /// - 参数: 被选中的菜单项
    public var didSelectBlock: ((AMPopoverMenuItem) -> Void)?
    
    private var tableView: UITableView!
    private weak var popoverView: AMPopover?
    private var menuItems: [AMPopoverMenuItem]
    
    // MARK: - Initialization
    
    /// 初始化一个菜单视图
    /// - Parameter menuItems: 菜单项数组
    public init(menuItems: [AMPopoverMenuItem]) {
        self.menuItems = menuItems
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        // 创建表格视图
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = menuBackgroundColor
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    /// 显示菜单
    /// - Parameter anchorView: 菜单的锚点视图，箭头将指向此视图
    public func show(with anchorView: UIView) {
        // 计算实际需要的高度
        let itemHeight = CGFloat(menuItems.count) * rowHeight
        let actualHeight = min(itemHeight, maxHeight)
        
        // 设置表格视图约束
        frame = CGRect(x: 0, y: 0, width: menuWidth, height: actualHeight)
        tableView.isScrollEnabled = actualHeight > maxHeight
        
        // 创建气泡视图
        let popupView = AMPopover(contentView: self)
        popupView.contentBackgroundColor = menuBackgroundColor
        popoverView = popupView
        // 显示气泡
        popupView.show(with: anchorView)
    }
    
    deinit {
        // print("AMPopoverMenuView dealloc")
    }
}

// MARK: - UITableViewDataSource

extension AMPopoverMenuView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].title
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .systemFont(ofSize: 14)
        cell.textLabel?.textColor = .label
        cell.backgroundColor = menuBackgroundColor
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AMPopoverMenuView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let block = didSelectBlock {
            block(menuItems[indexPath.row])
        }
        
        popoverView?.hide()
    }
} 
