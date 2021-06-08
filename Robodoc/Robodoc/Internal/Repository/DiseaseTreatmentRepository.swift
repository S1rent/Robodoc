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
        ("Pharyngitis", "You should get a good rest, don't talk too much if you have a sore throat, drink lots of water, use humidifier if the room feels dry, consume foods that is comfort in your throat, gargle with salt water, and avoid cigarette smoke and polution"),
        ("Narcolepsy", "You should exercise regularly for at least 30 minutes every day and avoid eating heavy meals before you go to bed."),
        ("Neurodermatitis","You have to protect your skin with a clean bandage or cloth."),
        ("ChestPain","You can consume a medicine called nitrogliserin or aspirin."),
        ("KneePain","To relieve the pain you should consume paracetamol or antiinflamation medicine, if your knee pain worsen you can do physiotherapy."),
        ("BackPain","The causes of back pain are very diverse, so a diagnosis is needed to determine the cause, and after that the doctor will give a suitable medicine for you."),
        ("Neuroblastoma","You need to go see a doctor now! An operation, chemotherapy, or radiotherapy is a must."),
        ("AnusPain","To cure this pain, you can soak your anus using a warm water, consume paracetamol medicine, consume a lot of water, and exercise regulary. If your anus pain worsen, you should consult to a doctor."),
        ("NeckPain","If you just felt a light pain in your neck, do a neck compress is enough to ease your pain, avoiding sudden neck movements are also necessary to cure this."),
        ("MusclePain","You should do exercise regularly (do some warm up and cooldown while you're at it), and consume a lot of water especially when if you often do strenous physical activity."),
        ("Myalgia", "You should do exercise regularly (do some warm up and cooldown while you're at it), and consume a lot of water especially when if you often do strenous physical activity."),
        ("WristPain","You can do some wrist compress if you have light pain. But if your wrist pain is serious you should consult to a doctor to get some physiotherapy or operation."),
        ("JointPain","You should get enough rest or consume some paracetamol to ease your pain."),
        ("Obesity","You should do some exercise regulary and consume weight loss drugs."),
        ("Orchitis","You should consume paracetamol medicine to ease the pain and get some enough rest"),
        ("Osteoporosis","You can reduce the risk of osteoporosis by quitting smoking, do not consume alcohol regularly, and do some exercise regularly."),
        ("Osteoarthritis","You should consume paracetamol or antiinflamation medicine, or if your pain worsen, you should consult to the doctor to get some proper treatment."),
        ("AcutePancreatitis","You have to reduce alcohol consumption, consume a healthy and nutritious food, avoid the consumption of high calorie foods, and exercise regularly."),
        ("TineaVersicolor","You can apply lotion or antifungi cream on the affected area"),
        ("Parestesia","You shoul consume vitamin B12 suplements."),
        ("Broken Wrist","You can consume a lot of vitamin D or calcium to avoid breaking bones in our body. You should also wear safety equipment when doing physical activities that can cause a broken wrist."),
        ("BrokenBone","You should consume or apply medicines to ease the pain, wear a gips that are made with plaster or fiberglass, and of course do some operations (if it's painful or serious)."),
        ("Pneumonia","You have to consume a nutritious food to strengthen your body's resistance, do not or quit smoke, and do not consume alcohol drinks"),
        ("Presbyopia","You can use glasses or contact lenses to improve your sight, or do some LASIK."),
        ("HeartDisease","You should consult with a doctor and consume recommended medicine. You could also eat healthy food (avoid high calorie foods)."),
        ("Polio","You can take some polio vaccine in the hospital."),
        ("Polycystic Kidney Disease","It is difficult to prevent polycystic kidney disease because it is an inheritad disease."),
        ("PTSD","You should consume some antidepressant medicine and consult with a doctor"),
        ("Headache","You should consume a lot of water, exercise regularly, and get enough rest."),
        ("Rabies","There is no method that can definitively treat rabies that has caused symptoms. However, handling of rabies has been carried out since the patient was bitten by an infectious animal suspected of carrying the rabies virus and no symptoms have appeared."),
        ("Rickets","You should consume a lot of vitamin D and calcium."),
        ("Rheumatoid","You should consume an anti inflammatic medicine and analgesic medicine."),
        ("Nightsightedness","You should consume foods that contain antioxidants and minerals, or you can use glasses."),
        ("Rhabdomyolysis","You should consume a lot of water before and after you do some physical activities."),
        ("Rubella","You should get a lot of rest and consume paracetamol medicine to ease the pain."),
        ("ToothPain","You should consume paracetamol medicine to ease the pain and wash your mouth using warm water or antiseptic medicine."),
        ("SARS","You should always wash your hand thoroughly and avoid going somewhere if not necessary."),
        ("Syphilis","You should consult to a doctor or consume some penicilin antibiotic medicine, and avoid sexual activities"),
        ("Scoliosis","You can consume some antiinflamation medicine or do some scoliosis operation (please consult to the doctor first)"),
        ("Stress","To reduce stress you can exercise regularly, get enough sleep, and reduce your caffein intake."),
        ("Stroke","You should exercise regularly, consume healthy food to decrease the risk of stroke, and avoid smoking and drinking alcohol to reduce the risk of stroke."),
        ("Tuberculosis","You should consult to a doctor and consume the medicine they have prepared. You also need to wear a mask to wherever you go and close your mouth when sneezing, coughing, and laughing."),
        ("Tetanus","You have to consume antitetanus medicine immediatly or go to the hospital to get some tetanus vaccine."),
        ("Thalassemia","Thalassemia is a genetic disorder that is prolonged, so treatment needs to be done for life. Patients with thalassemia will go through repeated blood transfusions to add blood cells that are lacking."),
        ("Typhus","You should consume antibiotic medicine and if worsen you have to get treated in the hospital."),
        ("BrainTumor","You should consult with a doctor and maybe get some operation done to remove your tumor."),
        ("Thrombocytopenia","You should avoid alcohol, and get some vaccine to decrease the virus that can reduce your thrombocyte."),
    ]
}
