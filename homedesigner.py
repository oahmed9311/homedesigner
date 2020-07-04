import numpy as np
import pandas as pd

from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.linear_model import LinearRegression
from sklearn.svm import SVC
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)
def gradeToNum(grade):
    grade = np.where(grade == 'A', 1, grade)
    grade = np.where(grade == 'A-', 2, grade)
    grade = np.where(grade == 'B', 3, grade)
    grade = np.where(grade == 'B-', 4, grade)
    grade = np.where(grade == 'C', 5, grade)
    grade = np.where(grade == 'C-', 6, grade)
    grade = np.where(grade == 'D', 7, grade)
    grade = np.where(grade == 'D-', 8, grade)
    grade = np.where(grade == 'F', 9, grade)
    return grade
def gradeToAlpha(grade):
    alpha = []
    for g in grade:
        g = round(g)
        if g <= 1: alpha.append('A')
        elif g <= 2: alpha.append('A-')
        elif g <= 3: alpha.append('B')
        elif g <= 4: alpha.append('B-')
        elif g <= 5: alpha.append('C')
        elif g <= 6: alpha.append('C-')
        elif g <= 7: alpha.append('D')
        elif g <= 8: alpha.append('D-')
        else: alpha.append('F')
    return alpha
def load_data(csv_path, train_length, grade_data):
    data_raw = pd.read_csv(csv_path)
    data = data_raw.drop(['name', 'orientation_grade', 'waster_grade', 'zoning_grade', 'overall_grade'], axis=1)
    X_norm = (data - data[:train_length].min()) / (data[:train_length].max() - data[:train_length].min())
    X_norm = X_norm.fillna(0)
    X_norm = X_norm.replace(np.inf, 1)
    X_norm = X_norm.replace(-np.inf, -1)
    y = data_raw[grade_data]
    return X_norm, y

def computeAccuracy(predicted, y_test):
    print ("**** Accuracy")
    predicted_num = gradeToNum(predicted)
    predicted_alpha = gradeToAlpha(predicted)
    y_test_num = gradeToNum(y_test.values)
    print('******** Predicted (Alpha Form): ', predicted_alpha)
    print('******** Predicted (Numeric Form): ', predicted_num)
    print('******** Actual (Alpha Form): ', [a for a in y_test])
    print('******** Actual (Numeric Form): ', y_test_num)
    distance = np.abs(np.subtract(predicted_num, y_test_num) / 9) / len(y_test_num)
    print('******** Normalized Distance: ', distance)
    print('******** Manhattan Distance: ', np.sum(distance))

def logisticRegression(x, y, x_test, y_test):
    lr = LogisticRegression(C=1000.0, random_state=0)
    lr.fit(x, y)

    predicted = lr.predict(x_test)
    computeAccuracy(predicted, y_test)


def kernelSvm(x, y, x_test, y_test):
    svm = SVC(kernel='rbf', random_state=0, gamma=0.1, C=100.0)
    svm.fit(x, y)

    predicted = svm.predict(x_test)
    computeAccuracy(predicted, y_test)

def linearRegression(x, y, x_test, y_test):
    y = gradeToNum(y.values)
    lr = LinearRegression().fit(x, y)

    predicted = lr.predict(x_test)
    computeAccuracy(predicted, y_test)



if __name__ == '__main__':
    data_len = 23
    train_start = 0
    train_len = 18
    test_start = 18
    test_len = 5
    data_file = "./features.csv"
    grade_data = "zoning_grade"
    X_norm, y = load_data(data_file, train_len, grade_data)

    X_train_norm = X_norm[train_start:train_start+train_len]
    X_test_norm = X_norm[test_start:test_start+test_len]
    y_train = y[train_start:train_start+train_len]
    y_test = y[test_start:test_start+test_len]

    #print(X_train_norm.to_string())
    #print(y_train.to_string())
    #print(X_test_norm.to_string())
    #print(y_test.to_string())
    linearRegression(X_train_norm, y_train, X_test_norm, y_test)
