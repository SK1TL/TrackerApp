//
//  PageViewController.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 14.05.2024.
//

import UIKit

final class PageViewController: UIPageViewController {
    private var pages: [Pages] = Pages.allCases
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var onboardingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вот это технологии!", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(onboardingTappedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
        setupPageController()
    }
    
    private func addSubviews() {
        [pageControl, onboardingButton].forEach{view.addSubview($0)}
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: onboardingButton.topAnchor, constant: -24),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            onboardingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -84),
            onboardingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onboardingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            onboardingButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc private func onboardingTappedButton() {
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    private func setupPageController() {
        dataSource = self
        delegate = self
        
        let initialVC = OnboardingViewController(with: pages[0])
        setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingViewController  else { return nil }
        var index = currentVC.page.index
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        return OnboardingViewController(with: pages[index])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingViewController  else { return nil }
        var index = currentVC.page.index
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
        return OnboardingViewController(with: pages[index])
    }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewControlle = pageViewController.viewControllers?.first as? OnboardingViewController {
            pageControl.currentPage = currentViewControlle.page.index
        }
    }
}
