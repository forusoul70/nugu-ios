//
//  MockDialogAttributeStore.swift
//  NuguTests
//
//  Created by MinChul Lee on 2020/05/28.
//  Copyright (c) 2020 SK Telecom Co., Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

import NuguAgents

class MockDialogAttributeStore: DialogAttributeStoreable {
    func getAttributes(key: String) -> [String: AnyHashable]? {
        return nil
    }
    
    func setAttributes(_ attributes: [String: AnyHashable], key: String) {
    }
    
    func requestAttributes(key: String?) -> [String: AnyHashable]? {
        return nil
    }
    
    func removeAttributes(key: String) {
    }
    
    func removeAllAttributes() {
    }
}
