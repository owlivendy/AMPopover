import UIKit

struct AMPopoverColor {
    static var defaultBackground: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .systemGray6  // 深色模式颜色
            } else {
                return .white  // 浅色模式颜色
            }
        }
    }
}

public class AMPopover: UIView {
    
    // MARK: - Properties
    
    /// 箭头的高度
    /// - 默认值: 8.0
    /// - 影响弹出框箭头的垂直高度
    public var arrowHeight: CGFloat = 8
    
    /// 箭头的宽度
    /// - 默认值: 12.0
    /// - 影响弹出框箭头的水平宽度
    public var arrowWidth: CGFloat = 12
    
    /// 弹出框的圆角半径
    /// - 默认值: 8.0
    /// - 影响弹出框内容视图的圆角大小
    public var cornerRadius: CGFloat = 8
    
    /// 弹出框距离屏幕边缘的最小边距
    /// - 默认值: 10.0
    /// - 确保弹出框不会太靠近屏幕边缘
    public var minMargin: CGFloat = 10
    
    /// 弹出框的背景颜色
    /// - 默认值: 深色模式为 .systemGray6，浅色模式为 .white
    /// - 同时影响内容视图和箭头的颜色
    /// - 设置此属性会自动更新内容视图和箭头的颜色
    public var contentBackgroundColor: UIColor = AMPopoverColor.defaultBackground {
        didSet {
            contentView.backgroundColor = contentBackgroundColor
            arrowLayer.fillColor = contentBackgroundColor.cgColor
        }
    }
    
    /// 弹出框的内容视图
    /// - 支持两种方式设置大小：
    ///   1. 通过设置 frame.size 直接指定大小
    ///   2. 使用 Auto Layout 约束，系统会自动计算合适的大小
    /// - 注意：如果同时设置了 frame.size 和 Auto Layout 约束，优先使用 frame.size
    private var contentView: UIView
    private var arrowLayer: CAShapeLayer
    private var isShowingAbove: Bool = false
    private var arrowOffset: CGFloat = 0 // 箭头相对于中心的偏移量
    private var backgroundView: UIView?
    
    // MARK: - Initialization
    
    /// 初始化一个弹出框
    /// - Parameter contentView: 要显示的内容视图
    public init(contentView: UIView) {
        self.contentView = contentView
        self.arrowLayer = CAShapeLayer()
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .clear
        
        // 设置内容视图
        contentView.backgroundColor = contentBackgroundColor
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        addSubview(contentView)
        
        // 创建箭头图层
        arrowLayer.fillColor = contentBackgroundColor.cgColor
        layer.addSublayer(arrowLayer)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // 更新箭头颜色
            arrowLayer.fillColor = contentBackgroundColor.cgColor
        }
    }
    
    // MARK: - Public Methods
    
    /// 显示弹出框
    /// - Parameter anchorView: 弹出框的锚点视图，箭头将指向此视图
    /// - Note: 弹出框会自动计算最佳显示位置，优先显示在锚点视图下方，如果空间不足则显示在上方
    public func show(with anchorView: UIView) {
        // 创建背景视图
        backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView?.backgroundColor = .clear
        
        // 设置背景视图阴影
        backgroundView?.layer.shadowColor = UIColor.black.cgColor
        backgroundView?.layer.shadowOffset = CGSize(width: 0, height: 2)
        backgroundView?.layer.shadowOpacity = 0.15
        backgroundView?.layer.shadowRadius = 4
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped(_:)))
        tapGesture.delegate = self
        backgroundView?.addGestureRecognizer(tapGesture)
        
        // 获取锚点视图在窗口中的位置
        let anchorFrame = anchorView.convert(anchorView.bounds, to: nil)
        
        // 计算内容视图的大小
        var contentSize: CGSize
        if contentView.frame.size != .zero {
            // 如果设置了 frame.size，直接使用
            contentSize = contentView.frame.size
        } else {
            // 使用 autolayout 计算大小
            contentSize = contentView.systemLayoutSizeFitting(
                CGSize(width: UIScreen.main.bounds.width - minMargin * 2, height: UIView.layoutFittingCompressedSize.height),
                withHorizontalFittingPriority: .fittingSizeLevel,
                verticalFittingPriority: .fittingSizeLevel
            )
        }
        
        // 计算气泡视图的总大小
        let totalWidth = contentSize.width
        let totalHeight = contentSize.height + arrowHeight
        
        // 计算气泡视图的位置
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // 计算水平位置
        var x = anchorFrame.origin.x + (anchorFrame.size.width - totalWidth) / 2
        
        // 确保弹窗不会超出屏幕右边
        if x + totalWidth > screenWidth - minMargin {
            x = screenWidth - totalWidth - minMargin
        }
        
        // 确保弹窗不会超出屏幕左边
        x = max(minMargin, x)
        
        // 计算箭头偏移量
        let anchorCenterX = anchorFrame.origin.x + anchorFrame.size.width / 2
        let popoverCenterX = x + totalWidth / 2
        arrowOffset = anchorCenterX - popoverCenterX
        
        // 计算垂直位置
        var y: CGFloat
        isShowingAbove = false
        
        // 尝试显示在下方
        y = anchorFrame.origin.y + anchorFrame.size.height
        if y + totalHeight > screenHeight - minMargin {
            // 如果下方空间不足，显示在上方
            y = anchorFrame.origin.y - totalHeight
            isShowingAbove = true
        }
        
        // 设置气泡视图的frame
        frame = CGRect(x: x, y: y, width: totalWidth, height: totalHeight)
        
        // 设置内容视图的frame
        if isShowingAbove {
            contentView.frame = CGRect(x: 0, y: 0, width: totalWidth, height: contentSize.height)
        } else {
            contentView.frame = CGRect(x: 0, y: arrowHeight, width: totalWidth, height: contentSize.height)
        }
        
        // 绘制箭头
        drawArrow()
        
        // 添加到窗口
        if let window = anchorView.window {
            window.addSubview(backgroundView!)
            backgroundView?.addSubview(self)
        }
        
        // 设置初始状态
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        // 添加动画
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    /// 隐藏弹出框
    /// - Note: 会播放一个淡出和缩小的动画效果
    public func hide() {
        // 添加消失动画
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.backgroundView?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Private Methods
    
    private func drawArrow() {
        let path = UIBezierPath()
        
        // 计算箭头位置，考虑偏移量
        let arrowX = bounds.size.width / 2 + arrowOffset
        let arrowY = isShowingAbove ? bounds.size.height - arrowHeight : 0
        
        if isShowingAbove {
            // 箭头向下
            path.move(to: CGPoint(x: arrowX - arrowWidth/2, y: arrowY))
            path.addLine(to: CGPoint(x: arrowX, y: arrowY + arrowHeight))
            path.addLine(to: CGPoint(x: arrowX + arrowWidth/2, y: arrowY))
        } else {
            // 箭头向上
            path.move(to: CGPoint(x: arrowX - arrowWidth/2, y: arrowY + arrowHeight))
            path.addLine(to: CGPoint(x: arrowX, y: arrowY))
            path.addLine(to: CGPoint(x: arrowX + arrowWidth/2, y: arrowY + arrowHeight))
        }
        
        path.close()
        arrowLayer.path = path.cgPath
    }
    
    @objc private func backgroundViewTapped(_ gesture: UITapGestureRecognizer) {
        hide()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        // print("AMPopover dealloc")
    }
}

// MARK: - UIGestureRecognizerDelegate

extension AMPopover: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // 获取触摸点在self中的位置
        let point = touch.location(in: self)
        
        // 如果触摸点在contentView内，不响应背景点击事件
        if contentView.frame.contains(point) {
            return false
        }
        
        return true
    }
}

