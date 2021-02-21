//
//  MonthForecastCollectionViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 31.12.2020.
//

import UIKit

class MonthForecastCollectionViewController: UICollectionViewController {
    
    let weatherService = WeatherService()
    var city: City?
    var weathers = [Weather]()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        
        if let city = city {
            weatherService.loadWeatherForecast(city: city.name) { [weak self] weathers in
                    self?.weathers = weathers
                    self?.collectionView?.reloadData()
                }
        }
        
        super.viewDidLoad()

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? WeatherCollectionViewCell {
            
            let weather = weathers[indexPath.row]
            cell.temperatureLabel.text = "\(weather.temp) C"
            
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let weatherDate = weather.date {
                let date = Date(timeIntervalSince1970: weatherDate)
                cell.dayLabel.text = dateFormatter.string(from: date)
            }
            
            let imageId = weather.weatherIcon
            // потом сделать нормальный запрос
            cell.weatherImage.load(url: URL(string: "http://openweathermap.org/img/wn/\(imageId)@2x.png")!)
           
            return cell
        }
        return UICollectionViewCell()
    }

}

// MARK: Custom Layout
class WeatherCollectionViewLayout: UICollectionViewLayout {

    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
                                          // Хранит атрибуты для заданных индексов

    var columnsCount = 2                  // Количество столбцов
    
    var cellHeight: CGFloat = 128         // Высота ячейки

    private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
    
    override func prepare() {
        self.cacheAttributes = [:] // Инициализируем атрибуты
     
        // Проверяем наличие collectionView
        guard let collectionView = self.collectionView else { return }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        // Проверяем, что в секции есть хотя бы одна ячейка
        guard itemsCount > 0 else { return }
        
        
        let bigCellWidth = collectionView.frame.width
        let smallCellWidth = collectionView.frame.width / CGFloat(self.columnsCount)
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
            
        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let isBigCell = (index + 1) % (self.columnsCount + 1) == 0
            
            if isBigCell {
                attributes.frame = CGRect(x: 0, y: lastY,
                                          width: bigCellWidth, height: self.cellHeight)
                
                lastY += self.cellHeight
            } else {
                attributes.frame = CGRect(x: lastX, y: lastY,
                                          width: smallCellWidth, height: self.cellHeight)
                
                let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
                if isLastColumn {
                    lastX = 0
                    lastY += self.cellHeight
                } else {
                    lastX += smallCellWidth
                }
            }
            
            cacheAttributes[indexPath] = attributes
            self.totalCellsHeight = lastY
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0,
                      height: self.totalCellsHeight)
    }
    
}
