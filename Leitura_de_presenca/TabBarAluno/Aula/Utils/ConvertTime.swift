

func convert_time(_ time: String) -> String {
    let timeArray = time.components(separatedBy: "T")
    let splitDate = timeArray[0].split(separator: "-")
    let formatDate = "\(splitDate[2])/\(splitDate[1])/\(splitDate[0])"
    return timeArray[1] + " " + formatDate
}
