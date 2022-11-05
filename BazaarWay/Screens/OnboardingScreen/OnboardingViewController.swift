//
//  OnboardingViewController.swift
//  BazaarWay
//
//  Created by Asım can Yağız on 3.11.2022.
//

import UIKit

final class OnboardingViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    
    // external controls
    let skipButton = UIButton()
    let nextButton = UIButton()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    // animations
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    var pageControlBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    // Functions for transfer to Main Screen
    @objc func basketButton(){
        //Setting basket button destination
        let basketScreenViewModel = BasketScreenViewModel()
        let basketScreenViewController = BasketScreenViewController(viewModel: basketScreenViewModel)
        present(basketScreenViewController, animated: true, completion: nil)
    }
    @objc func setScreenTransfer(){
        let mainScreenViewModel = MainScreenViewModel()
        let mainScreenViewController = MainScreenViewController(viewModel: mainScreenViewModel)
        let searchScreenViewModel = SearchScreenViewModel()
        let searchScreenViewController = SearchScreenViewController(viewModel: searchScreenViewModel)
        let profileScreenViewModel = ProfileScreenViewModel()
        let profileScreenViewController = ProfileScreenViewController(viewModel: profileScreenViewModel)
        
        let tabBarController = UITabBarController()
        mainScreenViewController.tabBarItem = UITabBarItem(title: "Products", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        searchScreenViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        profileScreenViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        tabBarController.viewControllers = [mainScreenViewController, searchScreenViewController, profileScreenViewController]
        
        //basket button settings
        let basketButtonImage = UIImage(systemName: "cart.fill")
        let basketBarButtonItem = UIBarButtonItem(image: basketButtonImage, style: .plain, target: self, action: #selector(basketButton))
        basketBarButtonItem.tintColor = .white
        tabBarController.navigationItem.rightBarButtonItem = basketBarButtonItem
        tabBarController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
}

//MARK: - Extensions

extension OnboardingViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let page1 = PagesViewController(animationName: "shop",
                                        titleText: "Welcome to BazaarWay",
                                        subtitleText: "The world’s smallest online store.")
        let page2 = PagesViewController(animationName: "search",
                                        titleText: "A online shopping platform",
                                        subtitleText: "The greatest journey of online shop.")
        let page3 = PagesViewController(animationName: "buy",
                                        titleText: "Your stores. Your place",
                                        subtitleText: "Whatever you’ve got in mind, we’ve got inside.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            skipButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
        ])
        
        // for animations
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
        pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2)
        
        skipButtonTopAnchor?.isActive = true
        nextButtonTopAnchor?.isActive = true
        pageControlBottomAnchor?.isActive = true
    }
}

extension UIPageViewController {
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
}

// MARK: - DataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap first
        }
    }
}

// MARK: - Delegates

extension OnboardingViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

// MARK: - Actions

extension OnboardingViewController {
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func skipTapped(_ sender: UIButton) {
        
        setScreenTransfer()
        
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        
        if pageControl.currentPage + 1 == lastPageIndex {
            nextButton.setTitle("Finish", for: .normal)
            skipButton.isHidden = true
            nextButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
        }
        goToNextPage()
        
        pageControl.currentPage += 1
    }
}


