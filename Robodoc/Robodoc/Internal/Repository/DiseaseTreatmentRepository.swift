//
//  DiseaseTreatmentRepository.swift
//  Robodoc
//
//  Created by IT Division on 08/06/21.
//

import Foundation

class DiseaseTreatmentRepository {
    public static let shared: DiseaseTreatmentRepository =  DiseaseTreatmentRepository()
    
    private init() { }
    
    let db: [(String, String)] = [
        ("Allergy", "If the cause of your allergy is known, you must avoid contact with that thing.\n\n You should go to hospital for further checkup and ask for anti-allergy meds like antihistamines and corticosteroids."),
        ("Amnesia", "Unfortunately, there is currently no meds can fully cure Amnesia. But here's few things should do:\nYou shouldn't consume alcohol too much.\nNotes, books, and picture can help you to remember things.\nDo further consultation to the hospital."),
        ("Anemia", "If you suffer anemia due to iron deficiency, consume foods / supplements that contain iron.\n\nIf you suffer anemia in pregnancy period, consume supplement that contain iron, vitamin B12 and folic acid (you can get the dose from hospital).\n\nIf the anemia is too chronic, you can do blood transfusion."),
        ("Asthma", "You should always bring relief inhaler. If the asthma is too chronic, get medical treatment at the hospital as soon as possible."),
        ("Cough", "You should get rest and.\n- Try to take a sip of honey\n- Consume common cough meds at your local store (make sure to read the dosage)\n- If the cough still exist, it may cause because of bacteria (you should visit a clinic or hospital) to get antibiotcs."),
        ("Cold", "You should consume supplement that contain zinc and vitamin C. Consume common cough meds at your local store (make sure to read the dosage). You can also consume a menthol candy to relieve the cold."),
        ("Bald", "You should use Minoxidil (available in forms of lotion or shampoo), Finasteride, Spironolactone, Kortikosteroid, or Diphnecyprone. Make sure to get the dosage from your local clinic / hospital."),
        ("Boil", "Compress the boil with warm water 3 times a day. And when the boil is broken, make sure to clean them with sterile gauze and anti-bacteria soap, then cover the boil with sterile gauze."),
        ("Stye", "Clean the area around the stye, compress with warm water, don't use contact lense, and you can also consume pain reliever like paracetamol (dont forget to read the dosage)."),
        ("Gallstone", "The best way to deal with gallstone is to do cholesyctomy. Because medicine is not effective against gallstone."),
        ("KidneyStone", "Ureteroscopy, extracorporeal shock wave lithotripsy (ESWL), percutaneous nephrolithotomy. If still possible, you can consume medicines like Allopurinol, Diuretic, and others (Make sure to get the dosage from your local clinics or hospital)."),
        ("Covid", "Isolate yourself in about 2 weeks, drink waters, get enough rest, consume pain reliever to relieve the cough, fever and pain. If you didn't get any better make sure to do further checkup at the hospital."),
        ("Measle", "Your body can heal itself from measle, but in order to help in relieving the pain, you can consume lots of water, pain reliever and vitamin A."),
        ("Hiccup", "Consume warm water and honey, gargle, hold you breath for a moment, take a deep breath, consume fresh ginger, take a sip of a fresh lemon."),
        ("Dehydration", "Drink lots of water. You can also consume infused water, or diluted fruit juice. If you get dehydration because of Diarrhea, don't drink juice, milk, and all kinds of drink that contain caffeine and soda."),
        ("Dengue Fever", "Unfortunately, there is no special method to resolve this disease. The best way you can do is to get a good rest, consume lots of water, consume febrifuge. DONT CONSUME ASPIRIN. Also the best treatment is to get a treatment from the hospital."),
        ("Fever", "Get a good rest, drink water, and consume fever reducer meds like Paracetamol. If fever is caused by infection, go and get a treatment from the hospital."),
        ("Diabetes", "You should diet and consume lots of fruit, vegetable, protein from grains, lower sugar consumption.\n\nIf you suffer type 1 diabetes, you can have insuline theraphy from doctor.\n\nIf you suffer type 2 diabetes, you can consume metformin from doctor."),
        ("Diarrhea", "Consume electrolyte fluid, consume soft food and consume antibiotics from doctor."),
        ("Epilepsy", "Consume antiepilepsi medicine such as carbamazepine, clobazam, levetiracetam, etc., to stabilize your electrical neuron activity in your brain."),
        ("Edema", "You should go on a diet, avoid sitting or standing up in a long time, exercise, and lower salt consumption."),
        ("Ebola", "You should get an infusion fluid to avoid dehydration, consume high blood pressure medicine, get extra oxygen, and you can also do blood transfusion if anemia exist."),
        ("Flu", "You should get a good rest, consume healthy food that contains vitamin C and drink lots of water. If you have severe flu, you should go to hospital."),
        ("Phobia", "Psychoteraphy (CBT or Desentization) or you could consume medicine like (Benzodiapine, Beta Blockers, and SSRI's)"),
        ("Pharyngitis", "You should get a good rest, don't talk too much if you have a sore throat, drink lots of water, use humidifier if the room feels dry, consume foods that is comfort in your throat, gargle with salt water, and avoid cigarette smoke and polution")
    ]
}
