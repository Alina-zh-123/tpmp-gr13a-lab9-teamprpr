import XCTest
import CoreData
@testable import lab9

final class PersistenceTests: XCTestCase {
    
    private var originalLanguages: [String]?
    
    override func setUp() {
        super.setUp()
        // Save original system languages to restore them after testing
        originalLanguages = UserDefaults.standard.stringArray(forKey: "AppleLanguages")
    }
    
    override func tearDown() {
        // Restore original languages
        if let originalLanguages = originalLanguages {
            UserDefaults.standard.set(originalLanguages, forKey: "AppleLanguages")
        } else {
            UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        }
        UserDefaults.standard.synchronize()
        super.tearDown()
    }
    
    func testPersistenceControllerInMemoryInit() {
        let controller = PersistenceController(inMemory: true)
        XCTAssertNotNil(controller.container)
        XCTAssertNotNil(controller.container.viewContext)
    }
    
    func testPersistenceControllerSharedInit() {
        let controller = PersistenceController.shared
        XCTAssertNotNil(controller.container)
        XCTAssertNotNil(controller.container.viewContext)
    }
    
    func testSeedInitialDataEnglish() {
        // Set language to English
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        let fetchRequest: NSFetchRequest<Branch> = Branch.fetchRequest()
        
        do {
            let branches = try context.fetch(fetchRequest)
            XCTAssertEqual(branches.count, 5)
            
            // Check specific english names and addresses
            let branchNames = branches.compactMap { $0.name }
            XCTAssertTrue(branchNames.contains("Branch No. 527/419"))
            XCTAssertTrue(branchNames.contains("CBU No. 527"))
            XCTAssertTrue(branchNames.contains("Branch No. 510/202"))
            XCTAssertTrue(branchNames.contains("CBU No. 514"))
            XCTAssertTrue(branchNames.contains("Branch No. 500/121"))
            
            let branchAddresses = branches.compactMap { $0.address }
            XCTAssertTrue(branchAddresses.contains("8 Avrorovskaya str."))
            XCTAssertTrue(branchAddresses.contains("7a Voronyanskogo str."))
            XCTAssertTrue(branchAddresses.contains("56 Nezavisimosti ave."))
            XCTAssertTrue(branchAddresses.contains("47a Surganova str."))
            XCTAssertTrue(branchAddresses.contains("119 Dzerzhinskogo ave."))
        } catch {
            XCTFail("Fetching branches failed: \(error)")
        }
    }
    
    func testSeedInitialDataItalian() {
        // Set language to Italian
        UserDefaults.standard.set(["it"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        let fetchRequest: NSFetchRequest<Branch> = Branch.fetchRequest()
        
        do {
            let branches = try context.fetch(fetchRequest)
            XCTAssertEqual(branches.count, 5)
            
            // Check specific italian names and addresses
            let branchNames = branches.compactMap { $0.name }
            XCTAssertTrue(branchNames.contains("Filiale N. 527/419"))
            XCTAssertTrue(branchNames.contains("CSB N. 527"))
            XCTAssertTrue(branchNames.contains("Filiale N. 510/202"))
            XCTAssertTrue(branchNames.contains("CSB N. 514"))
            XCTAssertTrue(branchNames.contains("Filiale N. 500/121"))
            
            let branchAddresses = branches.compactMap { $0.address }
            XCTAssertTrue(branchAddresses.contains("Via Avrorovskaya 8"))
            XCTAssertTrue(branchAddresses.contains("Via Voronyanskogo 7a"))
            XCTAssertTrue(branchAddresses.contains("Corso Nezavisimosti 56"))
            XCTAssertTrue(branchAddresses.contains("Via Surganova 47a"))
            XCTAssertTrue(branchAddresses.contains("Corso Dzerzhinskogo 119"))
        } catch {
            XCTFail("Fetching branches failed: \(error)")
        }
    }
    
    func testSeedInitialDataRussianAndFallback() {
        // Set language to Russian (or any unsupported, which triggers fallback to Russian)
        UserDefaults.standard.set(["ru"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        let fetchRequest: NSFetchRequest<Branch> = Branch.fetchRequest()
        
        do {
            let branches = try context.fetch(fetchRequest)
            XCTAssertEqual(branches.count, 5)
            
            // Check specific Russian names and addresses
            let branchNames = branches.compactMap { $0.name }
            XCTAssertTrue(branchNames.contains("Отделение №527/419"))
            XCTAssertTrue(branchNames.contains("ЦБУ №527"))
            XCTAssertTrue(branchNames.contains("Отделение №510/202"))
            XCTAssertTrue(branchNames.contains("ЦБУ №514"))
            XCTAssertTrue(branchNames.contains("Отделение №500/121"))
            
            let branchAddresses = branches.compactMap { $0.address }
            XCTAssertTrue(branchAddresses.contains("ул. Авроровская 8"))
            XCTAssertTrue(branchAddresses.contains("ул. Воронянского 7а"))
            XCTAssertTrue(branchAddresses.contains("пр-т Независимости 56"))
            XCTAssertTrue(branchAddresses.contains("ул. Сурганова 47а"))
            XCTAssertTrue(branchAddresses.contains("пр-т Дзержинского 119"))
        } catch {
            XCTFail("Fetching branches failed: \(error)")
        }
    }
    
    func testSeedInitialDataSkippedWhenNotEmpty() {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        let fetchRequest: NSFetchRequest<Branch> = Branch.fetchRequest()
        
        do {
            var count = try context.count(for: fetchRequest)
            XCTAssertEqual(count, 5)
            
            // Manually trigger seeding again on the same context
            controller.seedInitialData(context: context)
            
            // Count should remain 5, not double to 10
            count = try context.count(for: fetchRequest)
            XCTAssertEqual(count, 5)
        } catch {
            XCTFail("Count verification failed: \(error)")
        }
    }
}
