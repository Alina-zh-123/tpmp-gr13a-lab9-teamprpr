import CoreData
import Foundation

struct PersistenceController {
    
    //MARK: - Properties
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    //MARK: - Initialization
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "lab9")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        
        seedInitialData(context: container.viewContext)
    }

    func seedInitialData(context: NSManagedObjectContext) {
        seedBranches(context: context)
    }

    private func seedBranches(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Branch> = Branch.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                
            
                let systemLang = Locale.preferredLanguages.first ?? "ru"

                let lang: String
                if systemLang.hasPrefix("it") {
                    lang = "it"
                } else if systemLang.hasPrefix("en") {
                    lang = "en"
                } else {
                    lang = "ru"
                }
                
                let branch1 = Branch(context: context)
                branch1.lat = 53.8613
                branch1.lon = 27.5660
                if lang == "en" {
                    branch1.name = "Branch No. 527/419"
                    branch1.address = "8 Avrorovskaya str."
                } else if lang == "it" {
                    branch1.name = "Filiale N. 527/419"
                    branch1.address = "Via Avrorovskaya 8"
                } else if lang == "ru"{
                    branch1.name = "Отделение №527/419"
                    branch1.address = "ул. Авроровская 8"
                }

                let branch2 = Branch(context: context)
                branch2.lat = 53.8783
                branch2.lon = 27.5427
                if lang == "en" {
                    branch2.name = "CBU No. 527"
                    branch2.address = "7a Voronyanskogo str."
                } else if lang == "it" {
                    branch2.name = "CSB N. 527"
                    branch2.address = "Via Voronyanskogo 7a"
                } else if lang == "ru"{
                    branch2.name = "ЦБУ №527"
                    branch2.address = "ул. Воронянского 7а"
                }
                
                let branch3 = Branch(context: context)
                branch3.lat = 53.9184
                branch3.lon = 27.5884
                if lang == "en" {
                    branch3.name = "Branch No. 510/202"
                    branch3.address = "56 Nezavisimosti ave."
                } else if lang == "it" {
                    branch3.name = "Filiale N. 510/202"
                    branch3.address = "Corso Nezavisimosti 56"
                } else if lang == "ru" {
                    branch3.name = "Отделение №510/202"
                    branch3.address = "пр-т Независимости 56"
                }

                let branch4 = Branch(context: context)
                branch4.lat = 53.9268
                branch4.lon = 27.5878
                if lang == "en" {
                    branch4.name = "CBU No. 514"
                    branch4.address = "47a Surganova str."
                } else if lang == "it" {
                    branch4.name = "CSB N. 514" 
                    branch4.address = "Via Surganova 47a"
                } else {
                    branch4.name = "ЦБУ №514"
                    branch4.address = "ул. Сурганова 47а"
                }
                let branch5 = Branch(context: context)
                                branch5.lat = 53.8492
                                branch5.lon = 27.4764
                                if lang == "en" {
                                    branch5.name = "Branch No. 500/121"
                                    branch5.address = "119 Dzerzhinskogo ave."
                                } else if lang == "it" {
                                    branch5.name = "Filiale N. 500/121"
                                    branch5.address = "Corso Dzerzhinskogo 119"
                                } else {
                                    branch5.name = "Отделение №500/121"
                                    branch5.address = "пр-т Дзержинского 119"
                                }

                                try context.save()
                                print("Филиалы успешно загружены и локализованы!")
                            }
                        } catch {
                            print("Ошибка загрузки филиалов: \(error)")
                        }
                    }
                }
