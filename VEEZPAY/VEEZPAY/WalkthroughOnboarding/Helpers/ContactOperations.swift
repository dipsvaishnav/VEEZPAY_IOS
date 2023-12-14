//
//  ContactOperations.swift
//  eToll
//
//  Created by Mac on 05/08/21.
//

import Foundation
import Contacts


class ContactOperations
{
    
   class func fetchContactDetail() -> NSArray
   {
        let arrayNumber : NSMutableArray = []
        let contactStore = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataKey, CNContactPhoneNumbersKey,CNContactNamePrefixKey,CNContactImageDataAvailableKey]
        let request1 = CNContactFetchRequest(keysToFetch: keys  as [CNKeyDescriptor])
        try? contactStore.enumerateContacts(with: request1) { (contact, error) in
            for phone in contact.phoneNumbers {
                let number = phone.value
                let phoneN = number.value(forKey: "digits") as! String
                let name: String? = "\(contact.givenName) \(contact.familyName)"
                let pn = phoneN.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                print(name!)
                let dictContact : NSDictionary = ["name":name == "" ? pn:name!,"mobile":phoneN]
                arrayNumber.add(dictContact)
            }
        }
        let uniqueOrdered = Array(NSOrderedSet(array: arrayNumber as! [Any]))
        return (uniqueOrdered as? NSArray)!
    }
    class func getIPAddress() -> String {
         
         var address: String?
         var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
         if getifaddrs(&ifaddr) == 0 {
             var ptr = ifaddr
             while ptr != nil {
                 defer { ptr = ptr?.pointee.ifa_next }

                 guard let interface = ptr?.pointee else { return "" }
                 let addrFamily = interface.ifa_addr.pointee.sa_family
                 if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                     // wifi = ["en0"]
                     // wired = ["en2", "en3", "en4"]
                     // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                     let name: String = String(cString: (interface.ifa_name))
                     if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                         var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                         getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                         address = String(cString: hostname)
                     }
                 }
             }
             freeifaddrs(ifaddr)
         }
         return address ?? ""
     }
}
