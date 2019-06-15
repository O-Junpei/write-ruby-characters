import UIKit
import Alamofire

protocol WriteRubyModelInput {
    func fetchRubySentence(
        sentence: String,
        completion: @escaping (String) -> ())
}

class WriteRubyModel: WriteRubyModelInput {
    func fetchRubySentence(sentence: String, completion: @escaping (String) -> ()) {
        //お天気APIから東京の天気を取得する
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
                    return
                }
                
                guard let apiResponse = try? JSONDecoder().decode(APIResponse.self, from: data) else {
                    return
                }

                print(apiResponse.converted)
//                completion(apiResponse)

            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}
