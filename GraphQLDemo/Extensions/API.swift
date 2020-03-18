//
//  API.swift
//  GraphQLDemo
//
//  Created by Rohit Gupta on 20/02/20.
//  Copyright © 2020 Sahabe Alam. All rights reserved.
//

import Apollo
import Foundation


public final class AllCategoryListQuery: GraphQLQuery{
    
    public let operationDefinition: String = """
    query CatagoryList{
        viewer{
            categoryList{
                name
                _id
            }
        }
    }
    """
    
    public let operationName = "CatagoryList"
    public init() {
    }
//    public struct Data:GraphQLMap {
//        public let viewer:Viewer
//        public init (reader:GraphQLResultReader) throws{
//            viewer = try reader.value(for: Field(responseName:"viewer"))
//        }
//
//    }

    public struct Data: GraphQLSelectionSet {
     public static let possibleTypes = ["Query"]
        
     public static let selections: [GraphQLSelection] = [
      GraphQLField("viewer", type: .nonNull(.object(Launch.selections))),
     ]
        
     public private(set) var resultMap: ResultMap
     public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
        print(self.resultMap)
     }
    
     public init(launches: Launch) {
      self.init(unsafeResultMap: ["categoryList": launches.resultMap])
         print(launches)
     }
     public var launches: Launch {
      get {
       return Launch(unsafeResultMap: resultMap["categoryList"]! as! ResultMap)
      }
      set {
       resultMap.updateValue(newValue.resultMap, forKey: "categoryList")
      }
     }
        
     public struct Launch: GraphQLSelectionSet {
      public static let possibleTypes = ["LaunchConnection"]
//        public static let selections : [GraphQLSelection]  = [
//            GraphQLField("viewer", type: .object(selections1))
//        ]
        public static let selections : [GraphQLSelection]  = [
                  GraphQLField("categoryList", type: .object([
                   GraphQLField("name", type: .nonNull(.scalar(String.self))),
                   GraphQLField("_id", type: .nonNull(.scalar(String.self))),
                  ]))
              ]
//        public static let selections : [GraphQLSelection]  = [
//            GraphQLField("viewer", type: .nonNull(.object(selections2)))
//        ]
        
//      public static let selection: [GraphQLSelection] = [
//       GraphQLField("name", type: .nonNull(.scalar(String.self))),
//       GraphQLField("_id", type: .nonNull(.scalar(String.self))),
//      ]
      public private(set) var resultMap: ResultMap
      public init(unsafeResultMap: ResultMap) {
       self.resultMap = unsafeResultMap
        print(self.resultMap)
      }
      public init(name: String, id: String) {
       self.init(unsafeResultMap: ["name": name, "_id": id])
      }
//      public var __typename: String {
//       get {
//        return resultMap["__typename"]! as! String
//       }
//       set {
//        resultMap.updateValue(newValue, forKey: "__typename")
//       }
//      }
      public var name: String {
       get {
        return resultMap["name"]! as! String
       }
       set {
        resultMap.updateValue(newValue, forKey: "name")
       }
      }
      public var id: String {
            get {
             return resultMap["_id"]! as! String
            }
            set {
             resultMap.updateValue(newValue, forKey: "id")
            }
           }
     }
    }

}

