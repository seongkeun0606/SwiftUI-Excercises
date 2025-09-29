func example() {
    print("함수 시작")
    
    defer {
        print("defer 실행")
    }
    
    print("함수 끝")
}

example()
