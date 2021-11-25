//
//  CombineHelpers.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 24/11/21.
//

import Combine
import LazyFolksEngine
import Foundation

extension HTTPClient {
    typealias Publisher = AnyPublisher <(Data, HTTPURLResponse), Error>
    
    /// This method wraps the `HTTPClient.get` logic into a Combine publisher
    /// that way we could decorate any returned data to be converted to specific types
    /// or to be received on specific queues
    func getPublisher(from url: URL) -> Publisher {
        Deferred {
            Future { completion in
                self.get(from: url, completion: completion)
            }
        }.eraseToAnyPublisher()
    }
}

extension AnyPublisher {
    
    /// This method decorates our publishers to dispatch any logic in the `DispatchQueue.main`
    /// with this decoration our view controllers don't have to add ugly blocks to dispatch actions on the main queue
    /// they are agnostic of that kind of details
    func dispatchOnMainQueue() -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.immediateWhenOnMainQueueScheduler).eraseToAnyPublisher()
    }
    
}

extension DispatchQueue {
    static var immediateWhenOnMainQueueScheduler: ImmediateWhenOnMainQueueScheduler {
        ImmediateWhenOnMainQueueScheduler.shared
    }
    
    /// `ImmediateWhenOnMainQueueScheduler` will be in charge of checking if we are in the
    /// main queue, if we are not we dispatch the work in the main queue that way we will prevent unexpected behavior
    struct ImmediateWhenOnMainQueueScheduler: Scheduler {
        typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
        typealias SchedulerOptions = DispatchQueue.SchedulerOptions

        var now: SchedulerTimeType {
            DispatchQueue.main.now
        }

        var minimumTolerance: SchedulerTimeType.Stride {
            DispatchQueue.main.minimumTolerance
        }

        static let shared = Self()

        /// this key will identify our main queue value
        private static let key = DispatchSpecificKey<UInt8>()
        /// this is the value we will put in the main queue
        private static let value = UInt8.max

        private init() {
            /// On init we put a value in the main queue
            DispatchQueue.main.setSpecific(key: Self.key, value: Self.value)
        }

        private func isMainQueue() -> Bool {
            /// If we are able to get our value that means we are in the main queue
            DispatchQueue.getSpecific(key: Self.key) == Self.value
        }

        func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) {
            guard isMainQueue() else {
                return DispatchQueue.main.schedule(options: options, action)
            }

            action()
        }

        func schedule(after date: SchedulerTimeType, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) {
            DispatchQueue.main.schedule(after: date, tolerance: tolerance, options: options, action)
        }

        func schedule(after date: SchedulerTimeType, interval: SchedulerTimeType.Stride, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
            DispatchQueue.main.schedule(after: date, interval: interval, tolerance: tolerance, options: options, action)
        }
    }
}
