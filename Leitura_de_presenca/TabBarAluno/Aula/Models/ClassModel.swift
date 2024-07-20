

struct StudentClassModel: Hashable {
    var title: String
    var time: String
    var hasPresence: Bool
}


var classes: [StudentClassModel] = [
    StudentClassModel(title: "Banco de dados", time: "19:00 - 21/09/2024", hasPresence: false),
    StudentClassModel(title: "Cálculo II", time: "19:00 - 20/09/2024", hasPresence: true)
]
