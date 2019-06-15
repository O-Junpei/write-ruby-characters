import UIKit
import Alamofire

protocol HiraganaConvertModelInput {
    func fetchRubySentence(
        sentence: String,
        completion: @escaping (String?) -> ())
}

class HiraganaConvertModel: HiraganaConvertModelInput {
    func fetchRubySentence(sentence: String, completion: @escaping (String?) -> ()) {
        let url: String = "https://labs.goo.ne.jp/api/hiragana"
        let parameters: Parameters = [
            "app_id": APP_ID,
            "sentence": sentence,
            "output_type": "hiragana"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                guard let apiResponse = try? JSONDecoder().decode(APIResponse.self, from: data) else {
                    completion(nil)
                    return
                }

                completion(apiResponse.converted)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
