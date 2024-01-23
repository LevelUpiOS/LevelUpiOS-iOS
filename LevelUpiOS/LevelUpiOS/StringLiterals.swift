//
//  StringLiterals.swift
//  LevelUpiOS
//
//  Created by 김민재 on 1/23/24.
//

import Foundation


enum iOS {
    enum Swift {
        enum Optional {
            static var question1 = "Optional은 Swift에서 값이 항상 존재하는 것이 아닌, 없을 수도 있는 상황을 다루기 위한 개념이다."
            static var question2 = "옵셔널 변수를 강제 언래핑하면, 값이 없는 경우 앱이 크래시될 수 있다."
            static var question3 = "Swift에서 Optional 변수를 처리하는 안전한 방법 중 하나는 옵셔널 바인딩 (optional binding)을 사용하는 것이다"
        }
    }
    
    enum Memory {
        enum ARC {
            static var question1 = "ARC는 메모리 관리를 위한 자동화된 기술로, 개발자가 수동적으로 객체를 해제할 필요가 없다. (O/X)"
            static var question2 = "ARC의 주요 특징 중 하나는 순환 참조(Circular Reference)를 자동으로 감지하고 해제한다. (O/X)"
            static var question3 = "ARC에서 weak 키워드를 사용하면 참조를 가지지만 강한 참조로 취급되지 않아 순환 참조를 방지할 수 있다. (O/X)"
            
            static var answer1 = "ARC는 자동으로 참조 계수를 관리하여 메모리 누수를 방지하므로, 개발자는 수동으로 객체를 해제할 필요가 없습니다."
            static var answer2 = "ARC는 순환 참조를 자동으로 감지하고 메모리를 올바르게 해제하여 누수를 방지하는 기능을 제공합니다."
            static var answer3 = "weak 키워드를 사용하면 참조를 가지지만, 순환 참조를 방지하면서 참조 대상이 해제될 때 자동으로 nil로 설정됩니다."
        }
    }
    
    enum UIKit {
        enum LifeCycle {
            static var question1 = "View Controller의 Life Cycle 중 viewDidLoad 메서드는 뷰 계층이 메모리에 로드된 후 호출된다. (O/X)"
            static var question2 = "NotificationCenter를 통한 Observer 등록 시 주의해야 할 점은 해당 객체가 더 이상 필요하지 않을 때 옵저버를 해제해주어야 한다. (O/X)"
            static var question3 = "앱의 백그라운드 진입 시 호출되는 메서드는 applicationDidEnterBackground이다. (O/X)"
            
            static var answer1 = "viewDidLoad 메서드는 뷰 계층이 메모리에 로드된 직후에 호출되는 메서드로, 보통 초기화 코드나 뷰와 관련된 작업을 수행하기에 적합합니다."
            static var answer2 = "NotificationCenter를 사용할 때는 옵저버가 더 이상 필요하지 않을 때 명시적으로 옵저버를 해제해주어야 메모리 누수를 방지할 수 있습니다."
            static var answer3 = "applicationDidEnterBackground 메서드는 앱이 백그라운드로 진입할 때 호출되는 메서드로, 백그라운드에서 필요한 작업을 수행할 수 있습니다."
        }
    }
}
