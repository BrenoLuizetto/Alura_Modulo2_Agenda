//
//  MapaViewController.swift
//  Agenda
//
//  Created by Breno Luizetto Cintra on 30/12/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var mapa: MKMapView!
    
    //MARK: - Variavel
    
    var aluno:Aluno?
    lazy var localizacao = Localizacao()
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        localizarAluno()
        mapa.delegate = localizacao
    }
    
    //MARK: - Métodos
    
    func localizacaoInicial(){
        Localizacao().converteEnderecoEmCoordenadas(endereco: "Caelum - São Paulo")
        { (localizacaoEncontrada) in
            let pino = Localizacao().configuraPino(titulo: "Caelum", localizacao: localizacaoEncontrada, cor: .black, icon: nil)
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 5000, 5000)
            
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
        }
    }
    
    func localizarAluno(){
        if let aluno = aluno{
            Localizacao().converteEnderecoEmCoordenadas(endereco: aluno.endereco!) { (localizacaoEncontrada) in
//                let pino = self.connfiguraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
                let pino = Localizacao().configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada, cor: nil, icon: nil)
                
                self.mapa.addAnnotation(pino)
            }
            
        }
    }
    
        func getTitulo() -> String{
            return "Localizar Alunos"
        }
    
 
    
  


}
